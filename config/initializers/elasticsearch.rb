require 'elasticsearch'
require 'elasticsearch/transport/transport/http/faraday'

module Elasticsearch
  class Client
    def verify_elasticsearch
      # skip verification
    end
  end
end
