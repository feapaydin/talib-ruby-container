require 'talib_ruby'

# Calculates an RSI inde using TaLib
class RsiCalculator < ApplicationService
  attr_reader :payload, :error

  def initialize(args)
    super()
    @args = args
  end

  def call
    @payload = talib_rsi(@args[:data], @args[:period])

    !@payload.nil?
  end

  private

  def talib_rsi(data, period)
    f = TaLib::Function.new('RSI')
    out = Array.new(data.size)

    f.in_real(0, data)
    f.opt_int(0, period)
    f.out_real(0, out)
    f.call(0, data.size)
    
    out.compact[0...-1]
  end
end
