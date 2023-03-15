require_relative '../../../lib/infra/adapters/http/http_error'

class TakeHomeGatewayStub
  attr_reader :tweets, :status, :photos

  def initialize(tweets, status, photos)
    @tweets = tweets
    @status = status
    @photos = photos
  end
end
