# frozen_string_literal: true

class Calculator
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

  def call(mass, gravity, direction)
    fuel_calc(mass, gravity, direction)
  end

  private

  def fuel_calc(mass, gravity, direction)
    fuel_mass = fuel_calc_formula(mass, gravity, **ODDS.dig(direction)).round(0, :down)
    return 0 if fuel_mass.zero? || fuel_mass.negative?

    fuel_mass + fuel_calc(fuel_mass, gravity, direction)
  end

  def fuel_calc_formula(mass, gravity, k:, l:)
    BigDecimal(mass) * BigDecimal((gravity * k).to_s) - BigDecimal(l)
  end
end
