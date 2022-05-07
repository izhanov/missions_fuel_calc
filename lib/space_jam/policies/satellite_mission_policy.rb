# frozen_string_literal: true

module SpaceJam
  module Policies
    class SatelliteMissionPolicy < BasePolicy
      def apply(mass, trajectory)
        case trajectory
        in [Symbol => action, Float => gravity ]
          apply_formula(mass, gravity, **COEFFICENTS.dig(action))
        else
          raise ArgumentError, "Trajectory struct must be an Array<Symbol, Float>"
        end
      end

      private

      def apply_formula(mass, gravity, k:, l:)
        fuel_mass = (BigDecimal(mass.to_s) * BigDecimal((gravity * k).to_s) - BigDecimal(l.to_s)).round(0, :down)
        (mass + fuel_mass).to_i
      end
    end
  end
end

