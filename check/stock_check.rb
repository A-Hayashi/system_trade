# coding: utf-8



require "./lib/stock"

stock = Stock.new(8604, :t, 100)

puts stock.code
puts stock.market
puts stock.unit

stock.add_price("2011-07-01", 402, 402, 395, 397, 17495700)
stock.add_price("2011-07-02", 403, 405, 396, 397, 17495700)
stock.add_price("2011-07-03", 402, 402, 396, 337, 17495700)


puts stock.prices[0][:high]
puts stock.prices[0][:date]
puts stock.prices[1][:date]
puts stock.prices[2][:date]

p stock.prices
p stock.prices[0]

dates = stock.map_prices(:date)
puts dates[1]

open_prices = stock.map_prices(:open)
puts open_prices[0]
p dates

puts stock.map_prices(:open)
puts stock.open_prices



puts stock.dates[0]
puts stock.open_prices[1]
puts stock.high_prices[2]
puts stock.low_prices[0]
