# frozen_string_literal: true

module SpaceJam
  module MissionsTypes
    class SatelliteMissionType < BaseType
      def launch(mass, trajectory)
        case trajectory
        in [Symbol => action, Float => gravity ]
          apply_formula(mass, gravity, config.coefficients.(action))
        else
          raise ArgumentError, "Trajectory struct must be an Array<Symbol, Float>"
        end
      end

      private

      def apply_formula(mass, gravity, coefficients)
        current_mass = BigDecimal(mass.to_s)
        gravity_correction = BigDecimal((gravity * coefficients.k).to_s)
        current_coefficient = BigDecimal(coefficients.l.to_s)

        fuel_mass =
          (current_mass * gravity_correction - current_coefficient).round(0, :down)

        (mass + fuel_mass).to_i
      end
    end
  end
end

