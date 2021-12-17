# TaLib library test
# https://github.com/rivella50/talib-ruby
require 'rubygems'
require 'talib_ruby'

# init input data
# a = Array.new
# 10.times { |i| a.push i.to_f }

# 10.times do |k|
#     b = Array.new(10)
#     l = TaLib::Function.new("MA")
#     # setup input parameter
#     l.in_real(0,a)
#     # setup optional parameter
#     l.opt_int(0,k+2)
#     # setup output parameter
#     l.out_real(0,b)
#     lookback = l.lookback
#     l.call(0,9)
#     p "k=#{k+2}"
#     p b
# end


data = [50562, 50595, 50473, 47596, 47137, 49314, 50081, 46703, 48366, 48871, 47628, 47220,50562, 50595, 50473, 47596, 47137, 49314, 50081, 46703, 48366, 48871, 47628, 47220,50562, 50595, 50473, 47596, 47137, 49314, 50081, 46703, 48366, 48871, 47628, 47220,50562, 50595, 50473, 47596, 47137, 49314, 50081, 46703, 48366, 48871, 47628, 47220]

# Call TaLib RSI function with example data
def talib_rsi(data, period)
  f = TaLib::Function.new('RSI')
  out = Array.new(data.size)

  f.in_real(0, data)
  f.opt_int(0, period)
  f.out_real(0, out)
  f.call(0, data.size)
  out
end

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
    macdsignal: macdsignal.compact,
    macdhist: macdhist.compact
  }
end

p talib_macd(data)

