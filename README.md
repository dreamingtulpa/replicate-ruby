# Replicate Ruby client

This is a Ruby client for Replicate. It lets you run models from your Ruby code and do various other things on Replicate.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'replicate-ruby'
```

## Usage

Grab your token from replicate.com/account and authenticate by configuring `api_token`:

```ruby
Replicate.configure do |config|
  config.api_token = "your_api_token"
end
```

You can run a model and get its output:

```ruby
model = Replicate.client.retrieve_model("stability-ai/stable-diffusion")
prediction = model.latest_version.create_prediction(input: { prompt: "a handsome teddy bear" })
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/YOUR_GITHUB_USERNAME/replicate-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/YOUR_GITHUB_USERNAME/replicate-ruby/blob/master/CODE_OF_CONDUCT.md).
