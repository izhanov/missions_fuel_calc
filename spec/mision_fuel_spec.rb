# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/mission_fuel"

RSpec.describe MissionFuel do
  context "when no Calculator instance are passed to initializer" do
    it "raise ArgumentError" do
      expect{ subject }.to raise_error(ArgumentError)
    end
  end

  context "when Calculator instance are passed to initializer" do
    let(:calculator) { instance_double("Calculator") }

    it "create MissionFuel instance" do
      expect(MissionFuel.new(calculator: calculator)).to be_a(MissionFuel)
    end
  end

  describe "#calculate" do
    let(:calculator) { Calculator.new }

    context "when no arguments are passed" do
      it "raise ArgumentError" do
        expect{
          described_class.new(calculator: calculator).calculate
        }.to raise_error(ArgumentError)
      end
    end

    context "when mass are negative or zero" do
      it "raise ArgumentError" do
        expect{
          described_class.new(calculator: calculator).calculate(mass: 0, paths: [[:launch, 9.807]])
        }.to raise_error(ArgumentError)
      end
    end

    context "when arguments are correct" do
      context "for Appolo 11 mission" do
        let(:mission) {
          {
            mass: 28_801,
            paths: [
              [:launch, 9.807],
              [:land, 1.62],
              [:launch, 1.62],
              [:land, 9.807]
            ]
          }
        }
        it "returns 51898" do
          expect(
            described_class.new(calculator: calculator)
              .calculate(**mission)
          ).to eq 51_898
        end
      end

      context "for Mars mission" do
        let(:mission) {
          {
            mass: 14_606,
            paths: [
              [:launch, 9.807],
              [:land, 3.711],
              [:launch, 3.711],
              [:land, 9.807]
            ]
          }
        }
        it "returns 33388" do
          expect(
            described_class.new(calculator: calculator)
              .calculate(**mission)
          ).to eq 33_388
        end
      end

      context "for passenger ship" do
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
        it "returns 212161" do
          expect(
            described_class.new(calculator: calculator)
              .calculate(**mission)
          ).to eq 212_161
        end
      end
    end
  end
end
