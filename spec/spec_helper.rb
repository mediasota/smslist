require 'smslist'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def stub_post(path)
  WebMock::stub_request(:post, smslist_url(path))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def xml_response(file)
  {
    body: fixture(file),
    headers: {
      content_type: 'text/xml; charset=utf-8'
    }
  }
end

def smslist_url(url)
  if url =~ /^http/
    url
  else
    "#{Smslist::Configuration::DEFAULT_API_ENDPOINT}#{url}"
  end
end