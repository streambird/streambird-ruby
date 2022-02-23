# Streambird

This is the official Streambird RubyGem (`streambird`).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'streambird'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install streambird

## Usage

First, initialize the Streambird client:

```ruby
require 'streambird'

streambird = Streambird.new(api_key: 'API_KEY')
```

## Errors

This gem will raise exceptions on application-level errors. Here are the list of errors:

```ruby
Streambird::Api::BadRequest
Streambird::Api::TooManyRequests
Streambird::Api::NotFound
Streambird::Api::Unauthorized
Streambird::Api::InternalServerError
Streambird::Api::ConnectionError
Streambird::Api::APIKeyInvalid
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `streambird-ruby.gemspec`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To test locally, run `bundle exec rspec`. By default, client - server communication is mocked by [vcr](https://github.com/vcr/vcr), which uses local [casettes](spec/cassettes) recorded from production server.
To test against production server, set a test api key as `STREAMBIRD_TEST_API_KEY` and run `bundle exec rake spec:production`, which sets environment variable `STREAMBIRD_TEST_SERVER` to `production`. It will also update new client - server communication in the cassette.
Please note that changes in the cassettes will break existing specs. This is because 1) the server may return random results for test api key, and 2) some of the cassettes have been modified specifically for the specs.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/streambird/streambird-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
