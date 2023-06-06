# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

require_relative "space_jam/core"
require_relative "space_jam/configuration"
require_relative "space_jam/fuel_calculator"
require_relative "space_jam/missions_types/base_type"
require_relative "space_jam/missions_types/cargo_mission_type"
require_relative "space_jam/missions_types/satellite_mission_type"

module SpaceJam
  extend SpaceJam::Core

  configure do |config|
    config.coefficients = {
      launch: {
        k: 0.042,
        l: 33
      },
      land: {
        k: 0.033,
        l: 42
      }
    }.freeze
  end
end
