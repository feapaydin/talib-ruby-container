require 'talib_ruby'

# Performs TaLib calculations
class TechnicalAnalyzer < ApplicationService
  attr_reader :payload, :error

  def initialize(request_params)
    super()
    @args = request_params
  end

  def call
    preprocess_arguments || (return false)

    @payload = talib
    !@payload.nil?
  rescue RuntimeError => e
    @error = e.message
    false
  end

  private

  def preprocess_arguments
    @function_name = @args[:function_name]
    @data = @args[:data_list]
    @opts = @args[:option_list]

    if @data.nil? || @data.empty?
      @error = 'data_list required.'
      return false
    end

    true
  end

  def talib
    f = TaLib::Function.new(@function_name.upcase)
    data_size = @data.map(&:size).max

    @data.each_with_index do |data, i|
      f.in_real(i, data)
    end

    @opts&.each_with_index do |opt, i|
      f.opt_int(i, opt.to_i)
    end

    outs = []
    f.outs.times do |out_index|
      outs[out_index] = Array.new(data_size)
      f.out_real(out_index, outs[out_index])
    end

    f.call(0, data_size)
    outs.map(&:compact)
  end
end
