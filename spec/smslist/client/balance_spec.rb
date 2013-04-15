# coding: utf-8

require 'spec_helper'

describe Smslist::Client::Balance do
  let(:client) { Smslist::Client.new(token: 'secret') }

  describe '#balance' do
    it 'returns remaining balance' do
      stub_post('balance.php').to_return(xml_response('balance.xml'))
      expect(client.balance).to eq(10.0)
    end
  end

  describe '#remaining_sms' do
    it 'returns remaining sms count' do
      stub_post('balance.php').to_return(xml_response('balance.xml'))
      expect(client.remaining_sms).to eq(20)
    end
  end
end