require_relative '../../../../lib/infra/adapters/http/http_error'
require_relative '../../../../lib/infra/adapters/http/httparty_adapter'

describe HttpartyAdapter do
  let(:httparty_response) { Struct.new(:code, :parsed_response) }

  describe '#get' do
    it 'returns parsed content with sucessfull status code' do
      allow(described_class).to receive(:get).and_return(httparty_response.new(200, { 'data' => ['data 01', 'data 02', 'data 03'] }))
      parsed_content = subject.get('http://some.base.url/some-path')
      expect(parsed_content).to eq({ 'data' => ['data 01', 'data 02', 'data 03'] })
    end

    it 'raises an error with error status code' do
      allow(described_class).to receive(:get).and_return(httparty_response.new(400, { 'message' => 'some error message' }))
      expect do
        subject.get('http://some.base.url/some-path')
      end.to raise_error(HTTPError, 'URL: http://some.base.url/some-path | CODE: 400 | RESPONSE: {"message"=>"some error message"}')
    end

    it 'raises an eror when receives an invalid JSON format' do
      invalid_json_return = '{ "message": "some error message", "email": }'
      allow_any_instance_of(HTTParty::Parser).to receive(:body).and_return(invalid_json_return)
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(double(body: invalid_json_return, :'[]' => 'application/json', to_hash: {}, code: 200))
      expect do
        response = subject.get('http://some.base.url/some-path')
        p response.parsed_response
      end.to raise_error(HTTPError, 'URL: http://some.base.url/some-path | CODE: 200 | RESPONSE: Invalid JSON response')
    end

    it 'calls #get with right url' do
      allow(described_class).to receive(:get).and_return(httparty_response.new(200, { 'data' => ['data 01', 'data 02', 'data 03'] }))
      expect(described_class).to receive(:get).with('http://some.base.url/some-path', query: {}, headers: {})
      subject.get('http://some.base.url/some-path')
    end

    it 'calls #get with right header' do
      allow(described_class).to receive(:get).and_return(httparty_response.new(200, { 'data' => ['data 01', 'data 02', 'data 03'] }))
      expect(described_class).to receive(:get).with(
        'http://some.url/some-path',
        query: {},
        headers: { 'header-01' => 'value-01', 'header-02' => 'value-02', 'header-03' => 'value-03' }
      )
      subject.get('http://some.url/some-path', headers: { 'header-01' => 'value-01', 'header-02' => 'value-02', 'header-03' => 'value-03' })
    end

    it 'calls HTTParty #get with right query string' do
      allow(described_class).to receive(:get).and_return(httparty_response.new(200, { 'data' => ['data 01', 'data 02', 'data 03'] }))
      expect(described_class).to receive(:get).with('http://some.base.url/some-path', query: { 'some-query' => 'some-value' }, headers: {})
      subject.get('http://some.base.url/some-path', query: { 'some-query' => 'some-value' })
    end
  end
end
