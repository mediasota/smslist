require 'spec_helper'

describe Smslist::Client do

  describe 'api endpoint' do
    it 'defaults to https://my.smscell.ru/xml' do
      client = Smslist::Client.new
      expect(client.api_endpoint).to eq('https://my.smscell.ru/xml/')
    end
  end

  context 'Authentication module' do
    describe '#authentication' do
      it 'hash with a token, if token, login and password are set' do
        client = Smslist::Client.new(
          login: 'username',
          password: 'secret',
          token: 'api_token'
        )
        expect(client.authentication).to eql({ token: 'api_token' })
      end

      it 'hash with login and password, if login and password are set' do
        client = Smslist::Client.new(
          login: 'username',
          password: 'secret'
        )
        expect(client.authentication).to eql({ login: 'username', password: 'secret' })
      end

      it 'raises Smslist::UnauthorizedError, if credentials are not set' do
        client = Smslist::Client.new
        expect {
          client.authentication
        }.to raise_error(Smslist::UnauthorizedError)
      end
    end
  end

  context 'wrong credentials' do
    let(:client) { Smslist::Client.new(token: 'secret') }
    before(:each) do
      stub_post('balance.php').to_return(xml_response('wrong_credentials.xml'))
    end

    it 'raises Error' do
      expect {
        client.balance
      }.to raise_error(Smslist::Error)
    end
  end

  context 'Request module' do
    let(:client) { Smslist::Client.new }

    describe '#headers' do
      let(:headers) { client.send(:headers) }
      it 'Content-type is set to text/xml, charset is utf-8' do
        expect(headers).to include('Content-type' => 'text/xml; charset=utf-8')
      end

      it 'User-Agent is set' do
        expect(headers).to include('User-Agent' => "Smslist Ruby Gem #{Smslist::VERSION}")
      end
    end

    describe '#request_uri' do
      it 'returns API endpoint if method is nil' do
        expect(client.send(:request_uri)).to eql('https://my.smscell.ru/xml/')
      end

      it 'returns API endpoint if the method does not exist' do
        uri = client.send(:request_uri, :wrong_method)
        expect(uri).to eql('https://my.smscell.ru/xml/')
      end

      it 'returns full url to php script if the method exists' do
        uri = client.send(:request_uri, :balance)
        expect(uri).to eql('https://my.smscell.ru/xml/balance.php')
      end
    end
  end

end