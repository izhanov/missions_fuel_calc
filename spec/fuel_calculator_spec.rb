# frozen_string_literal: true

require "spec_helper"

require_relative "../lib/space_jam"

RSpec.describe SpaceJam::FuelCalculator do
  context "when no MissionPolicy instance are passed into constructor" do
    it "raise ArgumentError" do
      expect{ subject }.to raise_error(ArgumentError)
    end
  end

  describe "#call" do
    context "when mass should be positive" do
      let(:policy) { instance_double("MissionPolicy") }
      let(:calculator) { described_class.new(policy: policy) }

      it "raise ArgumentError" do
        expect{ calculator.call(mass: -12_432, steps: [[:launch, 9.807]]) }.to raise_error(ArgumentError)
        expect{ calculator.call(mass: 0, paths: [[:launch, 9.807]]) }.to raise_error(ArgumentError)
      end
    end

    context "when calculate for cargo mission" do
      let(:policy) { SpaceJam::Policies::CargoMissionPolicy.new }

      context "for Appolo 11 mission" do
        let(:mission) {
          {
            mass: 28_801,
            trajectory: [
              [:launch, 9.807],
              [:land, 1.62],
              [:launch, 1.62],
              [:land, 9.807]
            ]
          }
        }
        it "returns 51898" do
          expect(
            described_class.new(policy: policy)
              .call(**mission)
          ).to eq 51_898
        end
      end

      context "for Mars mission" do
        let(:mission) {
          {
            mass: 14_606,
            trajectory: [
              [:launch, 9.807],
              [:land, 3.711],
              [:launch, 3.711],
              [:land, 9.807]
            ]
          }
        }
        it "returns 33388" do
          expect(
            described_class.new(policy: policy)
              .call(**mission)
          ).to eq 33_388
        end
      end

      context "for passenger ship" do
        let(:mission) {
          {
            mass: 75_432,
            trajectory: [
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
            described_class.new(policy: policy)
              .call(**mission)
          ).to eq 212_161
        end
      end
    end

    context "when calculate for satellite mission" do
      let(:policy) { SpaceJam::Policies::SatelliteMissionPolicy.new }

      context "for Voyager 1" do
        let(:mission) {
          {
            mass: 825.5,
            trajectory: [:launch, 9.807]
          }
        }

        it "returns 1132" do
          expect(
            described_class.new(policy: policy)
              .call(**mission)
          ).to eq 1_132
        end
      end
    end
  end
end
