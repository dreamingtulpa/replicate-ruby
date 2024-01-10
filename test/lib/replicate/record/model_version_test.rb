# frozen_string_literal: true

require "test_helper"

class Replicate::Record::ModelVersionTest < MiniTest::Test
  def teardown
    client.webhook_url = nil
  end

  def test_predict_without_webhook_url
    response = {"completed_at"=>"2022-12-07T13:57:32.018353Z", "created_at"=>"2022-12-07T13:57:26.752050Z", "error"=>nil, "id"=>"test", "input"=>  {"width"=>1024,   "height"=>704,   "prompt"=>"painting of santa clause, winter background, in the style of a beautiful christmas xmas card, painterly, royalty-free, trending on artstation, by leonid afremov",   "negative_prompt"=>    "nsfw, nudity, child, gore, out of frame, watermark, signature, 3d render, disfigured, border, frame, stock image, text, typography, letter, digits, eyeless, pupilless, body out of frame, ugly, gross, deformed, cross-eye, blurry, bad anatomy, poorly drawn face, mutation, mutated, extra limbs, closed eyes, extra fingers, poorly drawn fingers, istockphoto watermark",   "num_inference_steps"=>25}, "logs"=>  "Using seed: 8654\n  0%|          | 0/25 [00:00<?, ?it/s]\n  4%|▍         | 1/25 [00:00<00:04,  5.19it/s]\n  8%|▊         | 2/25 [00:00<00:04,  5.63it/s]\n 12%|█▏        | 3/25 [00:00<00:03,  5.94it/s]\n 16%|█▌        | 4/25 [00:00<00:03,  6.09it/s]\n 20%|██        | 5/25 [00:00<00:03,  6.19it/s]\n 24%|██▍       | 6/25 [00:00<00:03,  6.24it/s]\n 28%|██▊       | 7/25 [00:01<00:02,  6.28it/s]\n 32%|███▏      | 8/25 [00:01<00:02,  6.30it/s]\n 36%|███▌      | 9/25 [00:01<00:02,  6.32it/s]\n 40%|████      | 10/25 [00:01<00:02,  6.33it/s]\n 44%|████▍     | 11/25 [00:01<00:02,  6.33it/s]\n 48%|████▊     | 12/25 [00:01<00:02,  6.34it/s]\n 52%|█████▏    | 13/25 [00:02<00:01,  6.34it/s]\n 56%|█████▌    | 14/25 [00:02<00:01,  6.34it/s]\n 60%|██████    | 15/25 [00:02<00:01,  6.34it/s]\n 64%|██████▍   | 16/25 [00:02<00:01,  6.35it/s]\n 68%|██████▊   | 17/25 [00:02<00:01,  6.35it/s]\n 72%|███████▏  | 18/25 [00:02<00:01,  6.34it/s]\n 76%|███████▌  | 19/25 [00:03<00:00,  6.34it/s]\n 80%|████████  | 20/25 [00:03<00:00,  6.34it/s]\n 84%|████████▍ | 21/25 [00:03<00:00,  6.34it/s]\n 88%|████████▊ | 22/25 [00:03<00:00,  6.34it/s]\n 92%|█████████▏| 23/25 [00:03<00:00,  6.35it/s]\n 96%|█████████▌| 24/25 [00:03<00:00,  6.35it/s]\n100%|██████████| 25/25 [00:03<00:00,  6.35it/s]\n100%|██████████| 25/25 [00:03<00:00,  6.28it/s]", "metrics"=>{"predict_time"=>5.226421}, "output"=>["https://replicate.delivery/pbxt/Wfqywp7J1M2f8ULNfM555H8DqzenDn4qNAu04kO0ZjRtcTeAC/out-0.png"], "started_at"=>"2022-12-07T13:57:26.791932Z", "status"=>"succeeded", "urls"=>{"get"=>"https://api.replicate.com/v1/predictions/test", "cancel"=>"https://api.replicate.com/v1/predictions/test/cancel"}, "version"=>"0827b64897df7b6e8c04625167bbb275b9db0f14ab09e2454b9824141963c966", "webhook"=>nil}

    stub_request(:post, "https://api.replicate.com/v1/predictions")
      .with(body: "{\"version\":\"0827b64897df7b6e8c04625167bbb275b9db0f14ab09e2454b9824141963c966\",\"input\":{\"prompt\":\"a cute teddy bear\"},\"webhook\":null}")
      .to_return(status: 200, body: response.to_json)

    version = Replicate::Record::ModelVersion.new(client, "id" => "0827b64897df7b6e8c04625167bbb275b9db0f14ab09e2454b9824141963c966")
    prediction = version.predict(prompt: "a cute teddy bear")

    assert_equal "test", prediction.id
    assert_nil prediction.webhook
  end

  def test_predict_with_default_webhook_url
    client.webhook_url = 'http://test.tld/replicate/webhook'

    response = {"completed_at"=>"2022-12-07T13:57:32.018353Z", "created_at"=>"2022-12-07T13:57:26.752050Z", "error"=>nil, "id"=>"test", "input"=>  {"width"=>1024,   "height"=>704,   "prompt"=>"painting of santa clause, winter background, in the style of a beautiful christmas xmas card, painterly, royalty-free, trending on artstation, by leonid afremov",   "negative_prompt"=>    "nsfw, nudity, child, gore, out of frame, watermark, signature, 3d render, disfigured, border, frame, stock image, text, typography, letter, digits, eyeless, pupilless, body out of frame, ugly, gross, deformed, cross-eye, blurry, bad anatomy, poorly drawn face, mutation, mutated, extra limbs, closed eyes, extra fingers, poorly drawn fingers, istockphoto watermark",   "num_inference_steps"=>25}, "logs"=>  "Using seed: 8654\n  0%|          | 0/25 [00:00<?, ?it/s]\n  4%|▍         | 1/25 [00:00<00:04,  5.19it/s]\n  8%|▊         | 2/25 [00:00<00:04,  5.63it/s]\n 12%|█▏        | 3/25 [00:00<00:03,  5.94it/s]\n 16%|█▌        | 4/25 [00:00<00:03,  6.09it/s]\n 20%|██        | 5/25 [00:00<00:03,  6.19it/s]\n 24%|██▍       | 6/25 [00:00<00:03,  6.24it/s]\n 28%|██▊       | 7/25 [00:01<00:02,  6.28it/s]\n 32%|███▏      | 8/25 [00:01<00:02,  6.30it/s]\n 36%|███▌      | 9/25 [00:01<00:02,  6.32it/s]\n 40%|████      | 10/25 [00:01<00:02,  6.33it/s]\n 44%|████▍     | 11/25 [00:01<00:02,  6.33it/s]\n 48%|████▊     | 12/25 [00:01<00:02,  6.34it/s]\n 52%|█████▏    | 13/25 [00:02<00:01,  6.34it/s]\n 56%|█████▌    | 14/25 [00:02<00:01,  6.34it/s]\n 60%|██████    | 15/25 [00:02<00:01,  6.34it/s]\n 64%|██████▍   | 16/25 [00:02<00:01,  6.35it/s]\n 68%|██████▊   | 17/25 [00:02<00:01,  6.35it/s]\n 72%|███████▏  | 18/25 [00:02<00:01,  6.34it/s]\n 76%|███████▌  | 19/25 [00:03<00:00,  6.34it/s]\n 80%|████████  | 20/25 [00:03<00:00,  6.34it/s]\n 84%|████████▍ | 21/25 [00:03<00:00,  6.34it/s]\n 88%|████████▊ | 22/25 [00:03<00:00,  6.34it/s]\n 92%|█████████▏| 23/25 [00:03<00:00,  6.35it/s]\n 96%|█████████▌| 24/25 [00:03<00:00,  6.35it/s]\n100%|██████████| 25/25 [00:03<00:00,  6.35it/s]\n100%|██████████| 25/25 [00:03<00:00,  6.28it/s]", "metrics"=>{"predict_time"=>5.226421}, "output"=>["https://replicate.delivery/pbxt/Wfqywp7J1M2f8ULNfM555H8DqzenDn4qNAu04kO0ZjRtcTeAC/out-0.png"], "started_at"=>"2022-12-07T13:57:26.791932Z", "status"=>"succeeded", "urls"=>{"get"=>"https://api.replicate.com/v1/predictions/test", "cancel"=>"https://api.replicate.com/v1/predictions/test/cancel"}, "version"=>"0827b64897df7b6e8c04625167bbb275b9db0f14ab09e2454b9824141963c966", "webhook"=>"http://test.tld/replicate/webhook"}

    stub_request(:post, "https://api.replicate.com/v1/predictions")
      .with(body: "{\"version\":\"0827b64897df7b6e8c04625167bbb275b9db0f14ab09e2454b9824141963c966\",\"input\":{\"prompt\":\"a cute teddy bear\"},\"webhook\":\"http://test.tld/replicate/webhook\"}")
      .to_return(status: 200, body: response.to_json)

    version = Replicate::Record::ModelVersion.new(client, "id" => "0827b64897df7b6e8c04625167bbb275b9db0f14ab09e2454b9824141963c966")
    prediction = version.predict(prompt: "a cute teddy bear")

    assert_equal "test", prediction.id
    assert_equal "http://test.tld/replicate/webhook", prediction.webhook
  end
end
