require 'rails_helper'

RSpec.describe Units::SiController, type: :controller do

  describe "Given a params units with a single unit" do
    let(:unit1) { "min" }
    let(:unit2) { "minute" }
    let(:unit3) { "hour" }
    let(:unit4) { "h" }
    let(:unit5) { "day" }
    let(:unit6) { "d" }
    let(:unit7) { "degree" }
    let(:unit8) { "°" }
    let(:unit9) { "\'" }
    let(:unit10) { "second" }
    let(:unit11) { "\"" }
    let(:unit12) { "hectare" }
    let(:unit13) { "ha" }
    let(:unit14) { "litre" }
    let(:unit15) { "L" }
    let(:unit16) { "tonne" }
    let(:unit17) { "t" }

    context "Type: Time Conversion" do
      it "convert minute" do
        get :index, params: { units: unit1 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("s")
        expect(json_response["multiplication_factor"]).to be_within(0.00000001).of(60)
      end

      it "convert min" do
        get :index, params: { units: unit2 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("s")
        expect(json_response["multiplication_factor"]).to be_within(0.00000001).of(60)
      end

      it "convert hour" do
        get :index, params: { units: unit3 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("s")
        expect(json_response["multiplication_factor"]).to eq(3600)
      end

      it "convert h" do
        get :index, params: { units: unit4 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("s")
        expect(json_response["multiplication_factor"]).to eq(3600)
      end

      it "convert day" do
        get :index, params: { units: unit5 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("s")
        expect(json_response["multiplication_factor"]).to eq(86400)
      end

      it "convert d" do
        get :index, params: { units: unit6 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("s")
        expect(json_response["multiplication_factor"]).to eq(86400)
      end
    end

    context "Type: Plane angle" do

      it "convert degree" do
        get :index, params: { units: unit7 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("rad")
        expect(json_response["multiplication_factor"]).to eq((Math::PI/180).round(14))
      end

      it "convert °" do
        get :index, params: { units: unit8 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("rad")
        expect(json_response["multiplication_factor"]).to eq((Math::PI/180).round(14))
      end

      it "convert \'" do
        get :index, params: { units: unit9 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("rad")
        expect(json_response["multiplication_factor"]).to eq((Math::PI/10800).round(14))
      end

      it "convert second" do
        get :index, params: { units: unit10 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("rad")
        expect(json_response["multiplication_factor"]).to eq((Math::PI/648000).round(14))
      end

      it "convert \"" do
        get :index, params: { units: unit11 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("rad")
        expect(json_response["multiplication_factor"]).to eq((Math::PI/648000).round(14))
      end
    end

    context "Type: Area" do

      it "convert hectare" do
        get :index, params: { units: unit12 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("m^2")
        expect(json_response["multiplication_factor"]).to eq(10000)
      end

      it "convert ha" do
        get :index, params: { units: unit13 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("m^2")
        expect(json_response["multiplication_factor"]).to eq(10000)
      end
    end

    context "Type: Volume" do
      it "convert litre" do
        get :index, params: { units: unit14 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("m^3")
        expect(json_response["multiplication_factor"]).to eq(0.001)
      end

      it "convert L" do
        get :index, params: { units: unit15 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("m^3")
        expect(json_response["multiplication_factor"]).to eq(0.001)
      end
    end

    context "Type: Mass" do
      it "convert tonne" do
        get :index, params: { units: unit16 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("kg")
        expect(json_response["multiplication_factor"]).to eq(10**3)
      end

      it "convert t" do
        get :index, params: { units: unit17 }
        json_response = JSON.parse(response.body)

        expect(json_response["unit_name"]).to eq("kg")
        expect(json_response["multiplication_factor"]).to eq(10**3)
      end
    end

  end
end
