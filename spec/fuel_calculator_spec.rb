# frozen_string_literal: true

require "spec_helper"
require_relative "../fuel_calculator"

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

      context "when missions paths incorrect" do
        it "raise ArgumentError with message" do
          expect{ FuelCalculator.call(mass: 12_445, paths: [[:launch, g], [:land, g], [:land, g]]) }.to raise_error(ArgumentError, "Incorrect mission path")
        end
      end

      context "when arguments correct" do
        it "return needed weight of fuel" do
          expect(FuelCalculator.call(mass: 12_445, paths: [[:launch, g], [:land, g], [:launch, g]]) ).to be_a(Integer)
        end
      end
    end
  end
end
