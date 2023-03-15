require_relative '../../../lib/infra/adapters/http/http_error'

class HttpAdapterStub
  def initialize(status: 200, &expected_return)
    @status = status
    @expected_return = expected_return
  end

  def get(url, *)
    raise HTTPError.new(url, @status, @expected_return.call) if @status >= 400

    @expected_return.call
  end
end
