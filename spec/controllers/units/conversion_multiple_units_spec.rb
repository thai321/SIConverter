require 'rails_helper'

RSpec.describe Units::SiController, type: :controller do
  describe "Given a params units without parenthesis" do
    let(:unit1) { "hour/second" }
    let(:unit2) { "hour/second*L" }
    let(:unit3) { "hour/second*L*d/ha/t" }

    it "convert 2 units" do
      get :index, params: { units: unit1 }
      json_response = JSON.parse(response.body)
      expected_unit = "s/rad"
      expected_factor = (3600/(Math::PI/648000)).round(14)

      expect(json_response["unit_name"]).to eq(expected_unit)
      expect(json_response["multiplication_factor"]).to eq(expected_factor)
    end

    it "convert 3 units" do
      get :index, params: { units: unit2 }
      json_response = JSON.parse(response.body)
      expected_unit = "s/rad*m^3"
      expected_factor = (3600/(Math::PI/648000)*0.001).round(14)

      expect(json_response["unit_name"]).to eq(expected_unit)
      expect(json_response["multiplication_factor"]).to eq(expected_factor)
    end

    it "convert many units" do
      get :index, params: { units: unit3 }
      json_response = JSON.parse(response.body)
      expected_unit = "s/rad*m^3*s/m^2/kg"
      expected_factor = (3600/(Math::PI/648000)*0.001*86400/10**4/10**3).round(14)

      expect(json_response["unit_name"]).to eq(expected_unit)
      expect(json_response["multiplication_factor"]).to eq(expected_factor)
    end
  end

  describe "Given a params units with parenthesis" do
    let(:unit1) { "(hour/°)" }
    let(:unit2) { "hour/(\'*L)" }
    let(:unit3) { "h/(\"*litre*day)/(hectare/°)*(min/L)" }

    it "convert 2 units" do
      get :index, params: { units: unit1 }
      json_response = JSON.parse(response.body)
      expected_unit = "(s/rad)"
      expected_factor = (3600/(Math::PI/180)).round(14)

      expect(json_response["unit_name"]).to eq(expected_unit)
      expect(json_response["multiplication_factor"]).to be_within(0.00000001).of(expected_factor)
    end

    it "convert 3 units" do
      get :index, params: { units: unit2 }
      json_response = JSON.parse(response.body)
      expected_unit = "s/(rad*m^3)"
      expected_factor = (3600/(Math::PI/10800*0.001)).round(14)

      expect(json_response["unit_name"]).to eq(expected_unit)
      expect(json_response["multiplication_factor"]).to be_within(0.0001).of(expected_factor)
    end

    it "convert many units" do
      get :index, params: { units: unit3 }
      json_response = JSON.parse(response.body)
      expected_unit = "s/(rad*m^3*s)/(m^2/rad)*(s/m^3)"
      expected_factor = (3600/((Math::PI/648000)*0.001*86400)/(10000/(Math::PI/180))*(60/0.001)).round(14)

      expect(json_response["unit_name"]).to eq(expected_unit)
      expect(json_response["multiplication_factor"]).to be_within(0.000000001).of(expected_factor)
    end
  end
end
