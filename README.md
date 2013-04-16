# Smslist

[![Gem Version](https://badge.fury.io/rb/smslist.png)][gem]
[![Build Status](https://secure.travis-ci.org/lebedev-yury/smslist.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/lebedev-yury/smslist.png?travis)][gemnasium]
[![Code Climate](https://codeclimate.com/github/lebedev-yury/smslist.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/lebedev-yury/smslist/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/smslist
[travis]: http://travis-ci.org/lebedev-yury/smslist
[gemnasium]: https://gemnasium.com/lebedev-yury/smslist
[codeclimate]: https://codeclimate.com/github/lebedev-yury/smslist
[coveralls]: https://coveralls.io/r/lebedev-yury/smslist

Simple Ruby wrapper for the SMSlist API. [SMSlist][smslist] is a service for mass sending sms messages.

[smslist]: http://www.smscell.ru

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

You will get a hash for each number, with status, message id (to retrieve status later) and number of parts:

```ruby
{
  '79031234567' => { status: :ok, id: 1001, parts: 2 },
  ...
  '79033456789' => { error: 'Номер телефона присутствует в стоп-листе.' }
}
```

Status :ok means, that the message was successfully placed in a queue.

### Getting state of sent messages

```ruby
message_ids = %w(1001 1002 1003 1004)
response = client.state(message_ids)
```

You will get a hash for id, with state and datetime, or error message.

## Supported Ruby Versions

This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0

If something doesn't work on one of these Ruby versions, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

## Inspiration
Smslist was inspired by [Octokit][].

[octokit]: https://github.com/pengwynn/octokit

## Copyright
Copyright (c) 2013 Yury Lebedev.
See [LICENSE][] for details.

[license]: LICENSE.md