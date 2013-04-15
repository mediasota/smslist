module Smslist
  class Client
    module Balance
      # Get account balance
      #
      # @return [Float] account balance
      # @example Get balance for user qwerty
      #   client = Smslist.new(login: 'qwerty', password: 'secret')
      #   client.balance
      def balance
        response = parse_xml(post build_xml_body.to_xml, :balance)
        response.xpath('response/money').text.to_f
      end

      # Get remaining sms count
      #
      # @return [Integer] remaining sms count
      # @example Get remaining sms count for user qwerty
      #   client = Smslist.new(login: 'qwerty', password: 'secret')
      #   client.remaining_sms
      def remaining_sms
        response = parse_xml(post build_xml_body.to_xml, :balance)
        response.xpath('response/sms').first.text.to_i
      end
    end
  end
end