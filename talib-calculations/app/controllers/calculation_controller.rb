# Actions to call calculation services
class CalculationController < ApplicationController
  def rsi
    service = RsiCalculator.call(params)
  
    if service.result
      render_success service.payload
    else
      render_bad_request service.error
    end
  end

  def macd
    service = MacdCalculator.call(params)

    if service.result
      render_success service.payload
    else
      render_bad_request service.error
    end
  end
end
