# coding: utf-8

require 'spec_helper'

describe Smslist::Client::State do

  describe '#state' do
    let(:client) { Smslist::Client.new(:token => 'secret') }
    let(:message_ids) { %w(1001 1002 1003 1004) }

    before(:each) { stub_post('state.php').to_return(xml_response('state.xml')) }

    it 'returns a Hash' do
      expect(client.state(message_ids)).to be_a(Hash)
    end

    it 'includes a Hash for delivered messages, with state' do
      expect(client.state(message_ids)['1001'][:state]).to eql('deliver')
    end

    it 'includes a Hash for delivered messages, with delivered datetime' do
      datetime = DateTime.strptime('2011-01-01 12:57:46', '%Y-%m-%d %H:%M:%S')
      expect(client.state(message_ids)['1001'][:datetime]).to be_within(1).of(datetime)
    end

    it 'includes a Hash for not delivered messages' do
      expect(client.state(message_ids)).
        to include('1004' => { :state => 'not_deliver',
          :error => 'The subscriber is absent or out of a coverage' })
    end
  end
end