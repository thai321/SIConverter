class Units::SiController < ApplicationController
  def index
    render json: { text: "hello" }
  end
end
