# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/space_jam/policies/satellite_mission_policy"

RSpec.describe SpaceJam::Policies::SatelliteMissionPolicy do
  describe "#apply" do

    let(:mass) { 28_801 }
    let(:trajectory) { [:launch, 9.807] }


    it "calculate weight of fuel" do
      expect(subject.apply(mass, trajectory)).to eq 40_630
    end
  end
end
