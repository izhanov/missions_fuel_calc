# frozen_string_literal: true

module SpaceJam
  module MissionsTypes
    class CargoMissionType < BaseType
      def launch(mass, trajectory)
        trajectory.reverse.reduce(0) do |result, (action, gravity)|
          fuel_mass = apply_formula(mass, gravity, config.coefficients.(action))
          mass += fuel_mass
          result += fuel_mass.to_i
        end
      end

      private

      def apply_formula(mass, gravity, coefficients)
        fuel_mass = (BigDecimal(mass.to_s) * BigDecimal((gravity * coefficients.k).to_s) - BigDecimal(coefficients.l.to_s)).round(0, :down)
        return 0 if fuel_mass.zero? || fuel_mass.negative?

        fuel_mass + apply_formula(fuel_mass, gravity, coefficients)
      end
    end
  end
end

