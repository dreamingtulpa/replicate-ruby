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

```ruby
upload = Replicate.client.upload_zip('tmp/data.zip') # replace with the path to your zip file
```

Then start training a new model using, for instance:

```ruby
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

As soon as the model has finished training, you can run predictions on it:

```ruby
prediction = Replicate.client.create_prediction(
  input: {
    prompt: 'your prompt, zwx style'
  },
  version: training.version
)
```

You can also download the `output.zip` file from the dreambooth training prediction, unzip it, and then convert the trained model to a Stable Diffusion checkpoint with [convert_diffusers_to_sd.py](https://gist.github.com/jachiam/8a5c0b607e38fcc585168b90c686eb05).

```bash
python ./convert_diffusers_to_sd.py --model_path ~/Downloads/output --checkpoint_path ~/Downloads/output.ckpt
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
