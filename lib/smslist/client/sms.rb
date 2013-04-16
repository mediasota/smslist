module Smslist
  class Client
    module Sms
      # Send sms message for a list of recipients
      #
      # @param text [String] Message text
      # @param recipients [Array] Array of phone numbers
      # @option values [Boolean] :flash True for flash sms messages
      # @return [Hash] Hash with statuses for each sent message
      # @example Send message to a list of users
      #   client = Smslist.new(token: 'secret', sender: '4040')
      #
      #   recipients = %w(79031234567 79032345678)
      #   client.send_sms('Message', recipients)
      def send_sms(text, recipients = [], options = {})
        unless sms_sender = sender
          raise Smslist::NoSenderError.new('You must set a sender')
        end

        body = build_xml_body do |xml|
          xml.message(type: "#{ 'flash' if options[:flash] }sms") {
            xml.sender sms_sender
            xml.text_ text.encode(:xml => :text)
            recipients.each_with_index do |recipient, index|
              xml.abonent :phone => recipient, :number_sms => index + 1
            end
          }
        end

        response = parse_xml(post body.to_xml)
        parse_send_sms_response(response, recipients)
      end

      private

      def parse_send_sms_response(response, recipients)
        response_array = response.xpath('response/information').map do |node|
          if node.text == 'send'
            [
              recipients[node[:number_sms].to_i - 1],
              {:status => :ok, :id => node['id_sms'].to_i, :parts => node['parts'].to_i }
            ]
          else
            [recipients[node[:number_sms].to_i - 1], { :error => node.text }]
          end
        end

        Hash[*response_array.flatten]
      end
    end
  end
end