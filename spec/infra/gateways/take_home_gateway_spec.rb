require_relative '../../../lib/infra/adapters/http/http_error'
require_relative '../../../lib/infra/gateways/take_home_gateway'
require_relative '../../support/stubs/http_adapter_stub'

describe TakeHomeGateway do
  describe '#tweets' do
    it 'returns expected tweets' do
      http_adapter = HttpAdapterStub.new do
        [{ 'username' => '@username01', 'tweet' => 'my tweet 01' }, { 'username' => '@username02', 'tweet' => 'my tweet 02' }]
      end
      subject = described_class.new(http_adapter)
      expect(subject.tweets).to eq([{ 'username' => '@username01', 'tweet' => 'my tweet 01' }, { 'username' => '@username02', 'tweet' => 'my tweet 02' }])
    end

    it 'raises HTTPError when receives some response status' do
      tweets_url = "#{ENV['TAKEHOME_BASE_URL']}/twitter"
      http_adapter = HttpAdapterStub.new(status: 400) { { 'message' => 'some error message' } }
      subject = described_class.new(http_adapter)
      expect do
        subject.tweets
      end.to raise_error(HTTPError, "URL: #{tweets_url} | CODE: 400 | RESPONSE: {\"message\"=>\"some error message\"}")
    end
  end

  describe '#status' do
    it 'returns expected tweets' do
      http_adapter = HttpAdapterStub.new do
        [{ 'name' => 'Some name 01', 'status' => 'This is my status 01' }, { 'name' => 'Some name 02', 'tweet' => 'This is my status 01 02' }]
      end
      subject = described_class.new(http_adapter)
      expect(subject.status).to eq([{ 'name' => 'Some name 01', 'status' => 'This is my status 01' }, { 'name' => 'Some name 02', 'tweet' => 'This is my status 01 02' }])
    end

    it 'raises HTTPError when receives some response status' do
      status_url = "#{ENV['TAKEHOME_BASE_URL']}/facebook"
      http_adapter = HttpAdapterStub.new(status: 400) { { 'message' => 'some error message' } }
      subject = described_class.new(http_adapter)
      expect do
        subject.status
      end.to raise_error(HTTPError, "URL: #{status_url} | CODE: 400 | RESPONSE: {\"message\"=>\"some error message\"}")
    end
  end

  describe '#photos' do
    it 'returns expected tweets' do
      http_adapter = HttpAdapterStub.new do
        [{ 'username' => 'username01', 'picture' => 'picture_01' }, { 'username' => 'username02', 'picture' => 'picture_02' }]
      end
      subject = described_class.new(http_adapter)
      expect(subject.photos).to eq([{ 'username' => 'username01', 'picture' => 'picture_01' }, { 'username' => 'username02', 'picture' => 'picture_02' }])
    end

    it 'raises HTTPError when receives some response status' do
      photos_url = "#{ENV['TAKEHOME_BASE_URL']}/instagram"
      http_adapter = HttpAdapterStub.new(status: 400) { { 'message' => 'some error message' } }
      subject = described_class.new(http_adapter)
      expect do
        subject.photos
      end.to raise_error(HTTPError, "URL: #{photos_url} | CODE: 400 | RESPONSE: {\"message\"=>\"some error message\"}")
    end
  end
end
