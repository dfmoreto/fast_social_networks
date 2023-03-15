require 'roda'

class RodaAdapter < Roda
  plugin :class_level_routing

  def self.endpoints
    @endpoints
  end

  def self.on(method, url, &block)
    @endpoints ||= []
    @endpoints << { method:, url:, block: }
  end

  def self.start
    endpoints.each do |endpoint|
      send(endpoint[:method], endpoint[:url]) do
        endpoint[:block].call(response)
      end
    end

    app
  end
end
