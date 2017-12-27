require 'rails_helper'

RSpec.describe Units::SiController, type: :controller do

  describe "Get #index" do
    it "return a success http status code of 200" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    context "when given no units params" do
      it "return an object with Missing params units error" do
        get :index
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq("Units params is missing or empty")
      end
    end

    context "when given invalid units params" do
      it "return an object with Invalid Input error" do
        get :index, params: { units: "degree/mina" }
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq("Invalid Input")
      end
    end

    context "when given a units params of empty string" do
      it "return an object with correct unit_name and multiplication_factor" do
        get :index, params: { units: "" }
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq("Units params is missing or empty")
      end
    end

    context "when given a valid units params" do
      it "return an object with correct unit_name and multiplication_factor" do
        get :index, params: { units: "degree/minute" }
        json_response = JSON.parse(response.body)

        expect(json_response["multiplication_factor"]).to eq(0.00029088820867)
      end
    end

  end
end
