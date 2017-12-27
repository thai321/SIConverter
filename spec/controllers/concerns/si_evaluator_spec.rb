require 'rails_helper'

RSpec.describe "Concerns::SiEvaluator" do

  context "Given units params with a single unit" do
    it "return a correct unit_name and factor" do
      si_unit = SiConversion::SiUnitConversion.new("hour")
      json_result = si_unit.get_result
      expect(json_result[:unit_name]).to be_instance_of(String)
      expect(json_result[:unit_name]).to eq("s")
      expect(json_result[:multiplication_factor]).to be_instance_of(Float)
      expect(json_result[:multiplication_factor]).to eq(3600)
    end
  end

  context "Given units params with multiple units" do
    it "return a correct unit_name and factor" do
      si_unit = SiConversion::SiUnitConversion.new("hour*degree/(d*L)")
      json_result = si_unit.get_result
      expected_unit = "s*rad/(s*m^3)"
      expected_factor = 3600*Math::PI/180/(86400*0.001)

      expect(json_result[:unit_name]).to be_instance_of(String)
      expect(json_result[:unit_name]).to eq(expected_unit)
      expect(json_result[:multiplication_factor]).to be_instance_of(Float)
      expect(json_result[:multiplication_factor]).to eq(expected_factor.round(14))
    end
  end
end
