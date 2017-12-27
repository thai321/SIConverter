class Units::SiController < ApplicationController
  include SiConversion

  def index
    if !params[:units] || params[:units].length == 0
      render json: { error: "Units params is missing or empty" }
    else
      si_unit = SiUnitConversion.new(units_params.strip)
      result = si_unit.get_result

      render json: result
    end
  end

  private
  def units_params
    params.require(:units)
  end

end
