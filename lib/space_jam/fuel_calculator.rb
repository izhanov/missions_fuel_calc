# frozen_string_literal: true

module SpaceJam
  class FuelCalculator
    attr_reader :mission_type

    def initialize(mission_type:)
      @mission_type = mission_type
    end

    def call(mass:, trajectory:)
      raise ArgumentError, "Mass should be positive" unless mass.positive?

      mission_type.launch(mass, trajectory)
    end
  end
end
