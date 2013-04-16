# coding: utf-8

require 'spec_helper'

describe Smslist::Client::Sms do

  describe '#send_sms' do
    context 'sender is set' do
      let(:client) { Smslist::Client.new(:token => 'secret', :sender => '4000') }
      let(:recipients) { %w(79031234567 79032345678 79033456789 79034567890) }

      before(:each) { stub_post('').to_return(xml_response('sms.xml')) }

      it 'returns a Hash' do
        expect(client.send_sms('Hello everyone', recipients)).to be_a(Hash)
      end

      it 'includes a Hash for sent messages, with status, id and parts count' do
        expect(client.send_sms('Hello everyone', recipients, :flash => true))
          .to include('79031234567' => { :status => :ok, :id => 1001, :parts => 2 })
      end

      it 'includes a Hash for not sent messages' do
        expect(client.send_sms('Hello everyone', recipients))
          .to include('79034567890' => { :error => 'Номер телефона присутствует в стоп-листе.' })
      end
    end

    context 'sender is not set' do
      let(:client) { Smslist::Client.new(:token => 'secret') }
      let(:recipients) { %w(79031234567) }

      it 'raises NoSenderError' do
        expect {
          client.send_sms('Hello everyone', recipients)
        }.to raise_error(Smslist::NoSenderError)
      end
    end
  end
end