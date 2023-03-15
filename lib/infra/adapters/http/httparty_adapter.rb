require 'httparty'
require_relative './http_error'

class HttpartyAdapter
  include HTTParty

  def get(url, headers: {}, query: {})
    response = self.class.get(url, headers:, query:)
    raise_error(url, response) if response.code >= 400
    response.parsed_response
  rescue JSON::ParserError
    raise HTTPError.new(url, response.code, 'Invalid JSON response')
  rescue SocketError
    raise HTTPError.new(url, 502, 'Error on trying to reach endpoint')
  end

  private

  def raise_error(url, response)
    raise HTTPError.new(url, response.code, response.parsed_response)
  end
end
