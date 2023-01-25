# frozen_string_literal: true

module Replicate
  module Record
    class Upload < Base
      def attach(path)
        client.update_upload(upload_url, path)
      end
    end
  end
end
