require_relative '../../support/stubs/http_adapter_stub'
require_relative '../../support/stubs/take_home_gateway_stub'
require_relative '../../../lib/infra/gateways/take_home_gateway'
require_relative '../../../lib/application/use_cases/social_networks_use_case'

describe SocialNetworksUseCase do
  describe '#call' do
    it 'returns a hash with :tweets, :status and :photos' do
      tweets = [{ 'username' => '@username01', 'tweet' => 'my tweet 01' } ]
      status = [{ 'name' => 'Some name 01', 'status' => 'This is my status 01' }]
      photos = [{ 'username' => 'username01', 'picture' => 'picture_01' }]
      take_home_gateway = TakeHomeGatewayStub.new(tweets, status, photos)
      subject = described_class.new(take_home_gateway)
      expect(subject.call).to eq({'twitter' => tweets, 'facebook' => status, 'instagram' => photos})
    end

    it 'returns a message error when raises a HTTPError' do
      http_adapter_error = HttpAdapterStub.new(status: 400) { 'some error' }
      take_home_gateway = TakeHomeGateway.new(http_adapter_error)
      subject = described_class.new(take_home_gateway)
      subject.call
      expect(subject.call).to eq({ 'message' => 'some error' })
    end
  end
end
