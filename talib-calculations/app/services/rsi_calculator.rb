require 'talib_ruby'

# Calculates an RSI inde using TaLib
class RsiCalculator < ApplicationService
  attr_reader :payload, :error

  def initialize(args)
    super
    @args = args.to_h
  end

  def call
    f = TaLib::Function.new(function: :rsi, args: %i[inReal inTimePeriod])
    f.call(inReal: @args[:data], inTimePeriod: @args[:period])

    @payload = f.output
  end
end
