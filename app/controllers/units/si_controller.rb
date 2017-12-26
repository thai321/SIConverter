class Units::SiController < ApplicationController
  def index
    if !params[:units] || params[:units].length == 0
      render json: { error: "Units params is missing or empty" }
    else
      render json: { value: units_params }
    end
  end

  private
  def units_params
    params.require(:units)
  end
end
