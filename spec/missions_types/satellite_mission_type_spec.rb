# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/space_jam/missions_types/satellite_mission_type"

RSpec.describe SpaceJam::MissionsTypes::SatelliteMissionType do
  describe "#apply" do

    let(:mass) { 28_801 }
    let(:trajectory) { [:launch, 9.807] }


    it "calculate weight of fuel" do
      expect(subject.launch(mass, trajectory)).to eq 40_630
    end
  end
end
