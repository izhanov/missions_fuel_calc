# missions_fuel_calc

# Goals

The goal of this application is to calculate fuel to launch from one planet of the Solar system, and to land on another planet of the Solar system, depending on flight route.

Application receive a flight route as 2 arguments. First one is the flight ship **mass**, and second is an **array of 2 elements tuples**, with first element being **land** or **launch** directive, and second element is the target planet **gravity**.

Arguments example for Appolo 11 mission: ```28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]```

The formula for fuel calculations for the launch is the following:
`mass * gravity * 0.042 - 33`

The formula for fuel calculations for the land is the following:
`mass * gravity * 0.033 - 42`

But fuel adds weight to the ship, so it requires additional fuel, until additional fueil is 0 or negative. Additional fuel is calculated using the same formula from above.

# Dependencies

- Ruby `2.7.0`
- RSpec `3.9.0`

# Usage

1. After cloning repo go to this directory:
`cd missions_fuel_calc/`

2. Start the console:
`bin/console`

3. Run the code:

`FuelCalculator.call(28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]])`
`=> 51898`

## Additionally
You can use seeds: APPOLO_11, MARS_MISSION, PASSENGER_SHIP

`FuelCalculator.call(**APPOLO_11)`
`=> 51898`
