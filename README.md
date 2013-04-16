# Smslist

Simple Ruby wrapper for the SMSlist API.

## Installation

```ruby
gem install smslist
```

## Configuration

You can configure this gem in an initializer:

```ruby
Smslist.configure do |c|
  c.sender = '79101234567'

  # you can use the token
  c.token = 'your_api_token'

  # or authenticate with login and password
  c.login = 'username'
  c.password = 'secret'
end
```

Or simply:

```ruby
client = Smslist.new(sender: '79101234567', token: 'your_api_token')
```

## Usage

### Getting the balance and remaining sms count

```ruby
balance = client.balance
remaining = client.remaining_sms
```

### Sending sms messages

```ruby
recipients = %w(79031234567 79032345678 79033456789)
response = client.send_sms('Your text message', recipients)
```

If can pass optional param, to send a flash sms message:

```ruby
response = client.send_sms('Your text message', recipients, flash: true)
```

## Inspiration
Smslist was inspired by [Octokit][].

[octokit]: https://github.com/pengwynn/octokit

## Copyright
Copyright (c) 2013 Yury Lebedev.
See [LICENSE][] for details.

[license]: LICENSE.md