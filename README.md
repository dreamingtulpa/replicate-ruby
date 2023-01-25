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

## Dreambooth

There is support for the [experimental dreambooth endpoint](https://replicate.com/blog/dreambooth-api).

First, upload your training dataset:

```
upload = Replicate.client.create_upload
upload.attach('tmp/data.zip') # replace with the path to your zip file
```

Then start training a new model using, for instance:

```
training = Replicate.client.create_training(
  input: {
    instance_prompt: "zwx style",
    class_prompt: "style",
    instance_data: upload.serving_url,
    max_train_steps: 5000
  },
  model: 'yourusername/yourmodel'
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
