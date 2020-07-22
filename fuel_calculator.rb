# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

module FuelCalculator
  extend self

  def call(mass:, paths:)
    raise ArgumentError, "Mass should be positive" unless mass.positive?
    raise ArgumentError, "Incorrect mission path" unless check_paths(paths)

    calculate(mass, paths, 0).to_i
  end

  private

  def calculate(mass, paths, acc)
    return acc if paths.empty?

    action, gravity = paths.shift

    fuel_mass = launch_calc(mass, gravity, 0) if action == :launch
    fuel_mass = land_calc(mass, gravity, 0) if action == :land

    acc += fuel_mass
    calculate(BigDecimal(mass + fuel_mass), paths, acc)
  end

  def launch_calc(mass, gravity, acc)
    return acc if mass.zero? || mass.negative?

    fuel_mass = (BigDecimal(mass.to_s) * BigDecimal(gravity.to_s) * BigDecimal(0.042.to_s) - BigDecimal(33))

    acc += fuel_mass if fuel_mass.positive?
    launch_calc(fuel_mass, gravity, acc)
  end

  def land_calc(mass, gravity, acc)
    return acc if mass.zero? || mass.negative?

    fuel_mass = (BigDecimal(mass) * BigDecimal(gravity.to_s) * BigDecimal(0.033.to_s) - BigDecimal(42))

    acc += fuel_mass if fuel_mass.positive?
    land_calc(fuel_mass, gravity, acc)
  end

  def check_paths(paths)
    counted_paths = paths.reduce({}) do |result, (action, _)|
      result[action] ? result[action] += 1 : result[action] = 1
      result
    end
    counted_paths.dig(:launch) >= counted_paths.dig(:land)
  end
end
