require 'dotenv/load'

require_relative './lib/infra/adapters/http/httparty_adapter'
require_relative './lib/infra/adapters/roda_adapter'
require_relative './lib/infra/gateways/take_home_gateway'
require_relative './lib/application/use_cases/social_networks_use_case'
require_relative './lib/infra/controllers/root_controller'

httparty_adapter = HttpartyAdapter.new
take_home_gateway = TakeHomeGateway.new(httparty_adapter)
social_networks_use_case = SocialNetworksUseCase.new(take_home_gateway)
RootController.new(RodaAdapter, social_networks_use_case)

run RodaAdapter.start
