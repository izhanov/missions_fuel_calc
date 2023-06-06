# frozen_string_literal: true

module SpaceJam
  module MissionsTypes
    class BaseType
      attr_reader :config

      def initialize
        @config = SpaceJam.configuration
      end

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
