# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/calculator"

RSpec.describe Calculator do
  it "must have ODDS" do
    expect(Calculator::ODDS).to be_a(Hash)
    expect(Calculator::ODDS.keys).to include(:launch, :land)
  end

  describe "#call" do
    context "when no arguments are passed" do
      it "raise ArgumentError" do
        expect{ subject.call }.to raise_error(ArgumentError)
      end
    end

    context "when arguments are passed" do
      let(:mass) { 28_801 }
      let(:g) { 9.807 }
      let(:direction) { :land }

      it "return fuell mass" do
        expect(subject.call(mass, g, direction)).to eq 13_447
      end
    end
  end
end
