# frozen_string_literal: true

APOLLO_11 = {
  mass: 28_801,
  trajectory: [
    [:launch, 9.807],
    [:land, 1.62],
    [:launch, 1.62],
    [:land, 9.807]
  ]
}.freeze

MARS_MISSION = {
  mass: 14_606,
  trajectory: [
    [:launch, 9.807],
    [:land, 3.711],
    [:launch, 3.711],
    [:land, 9.807],
  ]
}.freeze

PASSENGER_SHIP = {
  mass: 75_432,
  trajectory: [
    [:launch, 9.807],
    [:land, 1.62],
    [:launch, 1.62],
    [:land, 3.711],
    [:launch, 3.711],
    [:land, 9.807]
  ]
}.freeze
