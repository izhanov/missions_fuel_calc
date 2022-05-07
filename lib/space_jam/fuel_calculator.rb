# frozen_string_literal: true

module SpaceJam
  class FuelCalculator
    attr_reader :policy

    def initialize(policy:)
      @policy = policy
    end

    def call(mass:, trajectory:)
      raise ArgumentError, "Mass should be positive" unless mass.positive?

      policy.apply(mass, trajectory)
    end
  end
end
