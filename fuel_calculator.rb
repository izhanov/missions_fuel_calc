# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

module FuelCalculator
  extend self

  ODDS = {
    launch: {
      k: 0.042,
      l: 33
    },
    land: {
      k: 0.033,
      l: 42
    }
  }.freeze

  def call(mass:, paths:)
    raise ArgumentError, "Mass should be positive" unless mass.positive?

    calculate(mass, paths, 0).to_i
  end

  private

  def calculate(mass, paths, acc)
    return acc if paths.empty?

    action, gravity = paths.pop

    fuel_mass = fuel_calc(mass, gravity, 0, action: action)

    acc += fuel_mass
    calculate(BigDecimal(mass + fuel_mass), paths, acc)
  end

  def fuel_calc(mass, gravity, acc, action:)
    return acc if mass.zero? || mass.negative?

    fuel_mass = fuel_calc_formula(mass, gravity, **ODDS.dig(action)).round(0, :down)

    acc += fuel_mass if fuel_mass.positive?
    fuel_calc(fuel_mass, gravity, acc, action: action)
  end

  def fuel_calc_formula(mass, gravity, k:, l:)
    multiplication = BigDecimal(mass.to_s) * BigDecimal(gravity.to_s) * BigDecimal(k.to_s)
    multiplication - BigDecimal(l)
  end
end
