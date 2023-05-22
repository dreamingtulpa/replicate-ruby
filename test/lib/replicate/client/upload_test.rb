# frozen_string_literal: true

require "test_helper"

class Replicate::Client::UploadTest < MiniTest::Test
  def test_upload_zip
    stub_request(:post, "https://dreambooth-api-experimental.replicate.com/v1/upload/data.zip")
      .to_return(status: 200, body: "{ \"upload_url\": \"https://uploadurl.com\", \"serving_url\": \"https://servingurl.com\" }")

    zip = "PK\u0003\u0004\n\u0000\b\u0000\u0000\u0000Ԉ\xB6V\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\v\u0000 \u0000example.txtUT\r\u0000\a\u0001\x85kd\u0003\x85kd\u0001\x85kdux\v\u0000\u0001\u0004\xF5\u0001\u0000\u0000\u0004\u0014\u0000\u0000\u0000PK\a\b\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000PK\u0003\u0004\u0014\u0000\b\u0000\b\u0000Ԉ\xB6V\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\xA3\u0000\u0000\u0000\u0016\u0000 \u0000__MACOSX/._example.txtUT\r\u0000\a\u0001\x85kd\u0003\x85kd\u0006\x85kdux\v\u0000\u0001\u0004\xF5\u0001\u0000\u0000\u0004\u0014\u0000\u0000\u0000c`\u0015cg`b`\xF0MLV\xF0\u000FV\x88P\x80\u0002\x90\u0018\u0003'\u0010\e\u0001q!\u0010\x83\xF8\x8B\u0019\x88\u0002\x8E!!AP&H\xC7\f \xE6FS\u0088\u0010\u0017M\xCE\xCF\xD5K,(\xC8I\xD5+(\xCA/K\xCDK\xCCKN\u0005)8c)\u007Ftǂ\xA3\xF3\u0001PK\a\b\xBBל\xB6T\u0000\u0000\u0000\xA3\u0000\u0000\u0000PK\u0001\u0002\n\u0003\n\u0000\b\u0000\u0000\u0000Ԉ\xB6V\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\v\u0000 \u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\xA4\x81\u0000\u0000\u0000\u0000example.txtUT\r\u0000\a\u0001\x85kd\u0003\x85kd\u0001\x85kdux\v\u0000\u0001\u0004\xF5\u0001\u0000\u0000\u0004\u0014\u0000\u0000\u0000PK\u0001\u0002\u0014\u0003\u0014\u0000\b\u0000\b\u0000Ԉ\xB6V\xBBל\xB6T\u0000\u0000\u0000\xA3\u0000\u0000\u0000\u0016\u0000 \u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\xA4\x81Y\u0000\u0000\u0000__MACOSX/._example.txtUT\r\u0000\a\u0001\x85kd\u0003\x85kd\u0006\x85kdux\v\u0000\u0001\u0004\xF5\u0001\u0000\u0000\u0004\u0014\u0000\u0000\u0000PK\u0005\u0006\u0000\u0000\u0000\u0000\u0002\u0000\u0002\u0000\xBD\u0000\u0000\u0000\u0011\u0001\u0000\u0000\u0000\u0000"

    stub_request(:put, "https://uploadurl.com/")
      .with(
        body: zip,
        headers: {
          'Content-Length'=>'484',
          'Content-Type'=>'application/zip',
          'Transfer-Encoding'=>'chunked',
        }
      ).to_return(status: 200, body: "{}")

    client = Replicate::Client.new
    upload = client.upload_zip('test/fixtures/data.zip')
    assert_equal "https://servingurl.com", upload.serving_url
  end
end
