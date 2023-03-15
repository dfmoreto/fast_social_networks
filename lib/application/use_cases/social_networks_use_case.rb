class SocialNetworksUseCase
  def initialize(social_networks_gateway)
    @social_networks_gateway = social_networks_gateway
  end

  def call
    { 'twitter' => @social_networks_gateway.tweets, 'facebook' => @social_networks_gateway.status, 'instagram' => @social_networks_gateway.photos }
  rescue HTTPError => e
    { 'message' => e.response }
  end
end
