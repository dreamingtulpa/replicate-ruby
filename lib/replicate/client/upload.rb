# frozen_string_literal: true

module Replicate
  class Client
    # Methods for the Prediction API
    module Upload
      # Create an upload
      # @see https://replicate.com/blog/dreambooth-api
      def create_upload
        response = dreambooth_endpoint.post("upload/data.zip")
        Replicate::Record::Upload.new(self, response)
      end

      # Create an upload
      # @see https://replicate.com/blog/dreambooth-api
      def update_upload(upload_endpoint_url, zip_path)
        endpoint = Replicate::Endpoint.new(endpoint_url: upload_endpoint_url, api_token: nil)
        endpoint.agent.put do |req|
          req.headers["Content-Type"] = "application/zip"
          req.headers["Content-Length"] = File.size(zip_path).to_s
          req.headers["Transfer-Encoding"] = "chunked"
          req.body = Faraday::UploadIO.new(zip_path, 'application/zip')
        end
      end
    end
  end
end
