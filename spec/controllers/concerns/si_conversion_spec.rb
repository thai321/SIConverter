require 'rails_helper'

RSpec.describe "Concerns::SiConversion" do

  context "Initialize" do
    si_unit = SiConversion::SiUnitConversion.new("degree/minute")

    it "has a si_string" do
      expect(si_unit.si_string).to be_an(String)
      expect(si_unit.si_string).to eq("degree/minute")
    end

    it "has a num_decimal, default to 14" do
      expect(si_unit.num_decimal).to be_instance_of(Fixnum)
      expect(si_unit.num_decimal).to eq(14)
    end

    it "has a si_counter_part to be an empty hash" do
      expect(si_unit.si_counter_part).to be_an(Hash)
      expect(si_unit.si_counter_part).to eq({})
      expect(si_unit.si_counter_part.keys.length).to be(0)
    end
  end

  context "get_si_counter_part" do
    it "Create si_counter_part with its keys as name and symbol, and values as unit and factor" do
      si_unit = SiConversion::SiUnitConversion.new
      si_unit.get_si_counter_part
      expect(si_unit.si_counter_part).to be_an(Hash)
      expect(si_unit.si_counter_part.length).to eq(17)
    end
  end

  context "check_for_parenthesis" do
    it "return true if given units params contain parenthesis" do
      si_unit = SiConversion::SiUnitConversion.new("(degree/min)")
      expect(si_unit.check_for_parenthesis).to be(true)
    end

    it "return false if given units params contain parenthesis" do
      si_unit = SiConversion::SiUnitConversion.new("degree/min")
      expect(si_unit.check_for_parenthesis).to be(false)
    end
  end
end
