class RootController
  def initialize(server_adapter, social_networks_use_case)
    server_adapter.on(:get, '/') do |response|
      response.write(social_networks_use_case.call)
    end
  end
end
