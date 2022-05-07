# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/space_jam/policies/cargo_mission_policy"

RSpec.describe SpaceJam::Policies::CargoMissionPolicy do
  describe "#apply" do

    let(:mass) { 28_801 }
    let(:trajectory) {
      [
        [:launch, 9.807],
        [:land, 1.62],
        [:launch, 1.62],
        [:land, 9.807]
      ]
    }


    it "calculate weight of fuel" do
      expect(subject.apply(mass, trajectory)).to eq 51_898
    end
  end
end
