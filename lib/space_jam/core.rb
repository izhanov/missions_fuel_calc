# frozen_string_literal: true

module SpaceJam
  module Core
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
