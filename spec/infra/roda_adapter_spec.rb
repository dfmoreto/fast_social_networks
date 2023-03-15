require_relative '../../lib/infra/adapters/roda_adapter'

describe RodaAdapter do
  subject { described_class.dup }

  it '#on adds a new endpoint' do
    subject.on(:get, '/test')
    expect(subject.endpoints).to eq([{ method: :get, url: '/test', block: nil }])
  end

  it '#start calls Roda specific configured methods with routes' do
    subject.on(:get, '/test')
    expect(subject).to receive(:get).with('/test')
    subject.start
  end
end
