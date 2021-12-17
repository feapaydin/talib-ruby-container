# Actions to call calculation services
class CalculationController < ApplicationController
  def technical_analysis
    service = TechnicalAnalyzer.call(params)

    if service.result
      render_success service.payload
    else
      render_bad_request service.error
    end
  end
end
