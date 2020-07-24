# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/fuel_calculator"

RSpec.describe FuelCalculator do
  describe ".call" do
    let(:g) { 9.807 }

    context "when no arguments are passed" do
      it "raise ArgumentError" do
        expect{ FuelCalculator.call }.to raise_error(ArgumentError)
      end
    end

    context "when at least one argument is passed" do
      it "raise ArgumentError" do
        expect{ FuelCalculator.call(mass: 1245) }.to raise_error(ArgumentError)
      end
    end

    context "when arguments are passed" do
      context "when mass is zero" do
        it "raise ArgumentError with message" do
          expect{ FuelCalculator.call(mass: 0, paths: []) }.to raise_error(ArgumentError, "Mass should be positive")
        end
      end

      context "when arguments correct" do
        it "return needed weight of fuel" do
          expect(
            FuelCalculator.call(
              mass: 28_801,
              paths: [
                [:launch, 9.807], [:land, 1.62],
                [:launch, 1.62], [:land, 9.807]
              ]
            )
          ).to eq(51_898)
        end
      end

      context "when calculate Mars mission" do
        let(:mission) {
          {
            mass: 14_606,
            paths: [
              [:launch, 9.807],
              [:land, 3.711],
              [:launch, 3.711],
              [:land, 9.807],
            ]
          }
        }
        it "return 33388" do
          expect(FuelCalculator.call(**mission)).to eq 33_388
        end
      end

      context "when calculate Passenger ship mission" do
        let(:mission) {
          {
            mass: 75_432,
            paths: [
              [:launch, 9.807],
              [:land, 1.62],
              [:launch, 1.62],
              [:land, 3.711],
              [:launch, 3.711],
              [:land, 9.807]
            ]
          }
        }
        it "return 212161" do
          expect(FuelCalculator.call(**mission)).to eq 212_161
        end
      end
    end
  end
end
