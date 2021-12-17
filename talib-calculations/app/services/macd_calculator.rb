require 'talib_ruby'

# Calculates a MACD inde using TaLib
class MacdCalculator < ApplicationService
  attr_reader :payload, :error

  def initialize(request_params)
    super()
    @args = request_params
  end

  def call
    @payload = talib_macd(@args[:data])

    !@payload.nil?
  rescue RuntimeError => e
    @error = e.message
    false
  end

  private

  def talib_macd(data)
    f = TaLib::Function.new('MACD')
    macd = Array.new(data.size)
    macdsignal = Array.new(data.size)
    macdhist = Array.new(data.size)

    f.in_real(0, data)
    f.opt_int(0, 12)
    f.opt_int(1, 26)
    f.opt_int(2, 9)
    f.out_real(0, macd)
    f.out_real(1, macdsignal)
    f.out_real(2, macdhist)
    f.call(0, data.size)

    {
      macd: macd.compact,
      macd_signal: macdsignal.compact,
      macd_hist: macdhist.compact
    }
  end
end
