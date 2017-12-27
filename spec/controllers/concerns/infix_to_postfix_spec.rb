require 'rails_helper'

RSpec.describe "Concerns::InfixToPostfix" do

  context "Given units params without parenthesis" do
    it "return an array with params of single unit" do
      si_unit = SiConversion::SiUnitConversion.new("minute")
      si_unit.get_post_fix_expression
      expect(si_unit.expression).to be_an(Array)
      expect(si_unit.expression.length).to eq(1)
      expect(si_unit.expression).to eq(["minute"])
    end

    it "return an array of postfix order with multiple units" do
      si_unit = SiConversion::SiUnitConversion.new("degree*ha/minute")
      si_unit.get_post_fix_expression
      expect(si_unit.expression).to be_an(Array)
      expect(si_unit.expression.length).to eq(5)
      expect(si_unit.expression).to eq(["degree", "ha", "*" ,"minute", "/"])
    end
  end

  context "Given units params with parenthesis" do
    it "return an array with params of single unit" do
      si_unit = SiConversion::SiUnitConversion.new("(minute)")
      si_unit.get_post_fix_expression
      expect(si_unit.expression).to be_an(Array)
      expect(si_unit.expression.length).to eq(1)
      expect(si_unit.expression).to eq(["minute"])
    end

    it "return an array of postfix order with multiple units" do
      si_unit = SiConversion::SiUnitConversion.new("degree*(ha/minute)*(L*d)")
      si_unit.get_post_fix_expression
      expect(si_unit.expression).to be_an(Array)
      expect(si_unit.expression.length).to eq(9)
      expect(si_unit.expression).to eq(["degree", "ha", "minute", "/", "*", "L", "d", "*", "*"])
    end
  end
end
