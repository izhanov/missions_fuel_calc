# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

class MissionFuel
  attr_reader :calculator

  def initialize(calculator:)
    @calculator = calculator
  end

  def calculate(mass:, paths:)
    raise ArgumentError, "Mass should be positive" unless mass.positive?

    result = 0

    paths.reverse_each do |direction, gravity|
      fuel_mass = calculator.call(mass, gravity, direction)
      mass += fuel_mass
      result += fuel_mass
    end

    result.to_i
  end
end
