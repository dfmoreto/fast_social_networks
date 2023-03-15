class HTTPError < StandardError
  attr_reader :url, :code, :response

  def initialize(url, code, response)
    super("URL: #{url} | CODE: #{code} | RESPONSE: #{response}")
    @url = url
    @code = code
    @response = response
  end
end
