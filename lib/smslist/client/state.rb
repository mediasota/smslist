module Smslist
  class Client
    module State
      STATE_ERRORS = {
        1 => 'The subscriber is absent or out of a coverage',
        2 => 'Call barred service activated',
        3 => 'Unknown subscriber',
        4 => 'Memory capacity exceeded',
        5 => 'Equipment protocol error',
        6 => 'Teleservice not provisioned',
        7 => 'Facility not supported',
        8 => 'Subscriber is busy',
        9 => 'Roaming restrictions',
        10 => 'Timeout',
        11 => 'SS7 routing error',
        12 => 'Internal system failure',
        13 => 'SMSC failure'
      }.freeze

      # Get state for a list of message ids
      #
      # @param message_ids [Array] Array of message ids
      # @return [Hash] Hash with state, time or error for each message
      # @example Get state for a list of message ids
      #   client = Smslist.new(token: 'secret')
      #
      #   message_ids = %w(10001 10002 10003)
      #   client.state(message_ids)
      def state(message_ids = [])
        body = build_xml_body do |xml|
          xml.get_state {
            message_ids.each do |id|
              xml.id_sms id
            end
          }
        end

        response = parse_xml(post body.to_xml, :state)
        parse_state_response(response)
      end

      private

      def parse_state_response(response)
        response_array = response.xpath('response/state').map do |node|
          if node[:err] == '0'
            [
              node['id_sms'],
              {
                :state => node.text,
                :datetime => DateTime.strptime(node['time'], '%Y-%m-%d %H:%M:%S')
              }
            ]
          else
            [node['id_sms'], { :state => node.text,
              :error => STATE_ERRORS[node['err'].to_i] }]
          end
        end

        Hash[*response_array.flatten]
      end
    end
  end
end