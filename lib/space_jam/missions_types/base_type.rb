# frozen_string_literal: true

module SpaceJam
  module MissionsTypes
    class BaseType
      COEFFICENTS = {
        launch: {
          k: 0.042,
          l: 33
        },
        land: {
          k: 0.033,
          l: 42
        }
      }.freeze

      def launch(mass, paths)
        raise NotImplementedError, "Need implement in child class"
      end

      private

      def apply_formula(mass, gravity, k:, l:)
        raise NotImplementedError, "Need implement in child class"
      end
    end
  end
end
