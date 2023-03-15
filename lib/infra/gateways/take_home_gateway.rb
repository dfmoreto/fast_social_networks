class TakeHomeGateway
  TWEET_PATH = '/twitter'.freeze
  STATUS_PATH = '/facebook'.freeze
  PHOTO_PATH = '/instagram'.freeze

  def initialize(http_adapter)
    @http_adapter = http_adapter
  end

  def tweets
    @http_adapter.get("#{ENV['TAKEHOME_BASE_URL']}#{TWEET_PATH}")
  end

  def status
    @http_adapter.get("#{ENV['TAKEHOME_BASE_URL']}#{STATUS_PATH}")
  end

  def photos
    @http_adapter.get("#{ENV['TAKEHOME_BASE_URL']}#{PHOTO_PATH}")
  end
end
