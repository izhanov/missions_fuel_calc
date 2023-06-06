# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/space_jam/configuration"

RSpec.describe SpaceJam::Configuration do
  it "should store config" do
    config = described_class.new({ foo: "bar", baz: {qux: "qux" }})
    expect(config.foo).to eq("bar")
    expect(config.baz.qux).to eq("qux")
  end

  it "should assign config" do
    config = described_class.new
    config.foo = "bar"
    config.baz = {qux: "qux" }
    expect(config.foo).to eq("bar")
    expect(config.baz.qux).to eq("qux")
  end
end
