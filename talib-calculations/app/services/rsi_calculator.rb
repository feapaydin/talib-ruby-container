require 'talib_ruby'

# Calculates an RSI inde using TaLib
class RsiCalculator < ApplicationService
  attr_reader :payload, :error

  def initialize(args)
    super()
    @args = args.to_h
  end

  def call
    f = TaLib::Function.new('RSI')
    f.in_real(0, @args[:data])
    f.opt_int(0, @args[:period])
    f.out_real(0, @payload)
    f.call(0, @data.size)

    @payload.nil?
  end
end
