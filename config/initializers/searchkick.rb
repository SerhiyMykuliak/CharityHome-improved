Searchkick.client = Elasticsearch::Client.new(
  url: ENV['BONSAI_URL'],
  transport_options: {
    request: { timeout: 250 }
  }
)
