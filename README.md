# Replicate Ruby client

This is a Ruby client for [Replicate](https://replicate.com/). It lets you run models from your Ruby code and do various other things on Replicate.

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

You can retrieve a model:

```ruby
# Latest version
model = Replicate.client.retrieve_model("stability-ai/stable-diffusion")
version = model.latest_version

# List of versions
version = Replicate.client.retrieve_model("stability-ai/stable-diffusion", version: :all)

# Specific version
version = Replicate.client.retrieve_model("stability-ai/stable-diffusion", version: "<id>")
```

And then run predictions on it:

```ruby
prediction = version.predict(prompt: "a handsome teddy bear")

# manually refetch the prediction status
prediction = prediction.refetch

# or cancel a running prediction
prediction = prediction.cancel

# and if a prediction returns with status succeeded, you can retrieve the output
output = prediction.output

# Optionally you can submit a webhook url for replicate to send a POST request once a prediction has completed
prediction = version.predict(prompt: "a handsome teddy bear", "https://webhook.url/path") # call predict
id = prediction.id # store prediction id in your backend
prediction = Replicate.client.retrieve_prediction(id) # retrieve prediction during webhook with id from backend
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
