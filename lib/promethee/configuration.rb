module Promethee
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :route_scope

    def initialize
      @route_scope = 'promethee'
    end
  end
end
