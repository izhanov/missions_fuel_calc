# frozen_string_literal: true

module SpaceJam
  module Policies
    class CargoMissionPolicy < BasePolicy
      def apply(mass, trajectory)
        trajectory.reverse.reduce(0) do |result, (action, gravity)|
          fuel_mass = apply_formula(mass, gravity, **COEFFICENTS.dig(action))
          mass += fuel_mass
          result += fuel_mass.to_i
        end
      end

      private

      def apply_formula(mass, gravity, k:, l:)
        fuel_mass = (BigDecimal(mass.to_s) * BigDecimal((gravity * k).to_s) - BigDecimal(l.to_s)).round(0, :down)
        return 0 if fuel_mass.zero? || fuel_mass.negative?

        fuel_mass + apply_formula(fuel_mass, gravity, k: k, l: l)
      end
    end
  end
end

