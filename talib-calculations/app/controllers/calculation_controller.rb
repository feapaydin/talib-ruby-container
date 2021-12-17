# Actions to call calculation services
class CalculationController < ApplicationController
  def rsi
    service = RsiCalculator.call(rsi_params)

    if service.result
      render_success service.payload
    else
      render_bad_request service.error
    end
  end


  private

  def rsi_params
    params.permit(:data, :period)
  end
end
