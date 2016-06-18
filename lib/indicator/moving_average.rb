# coding: utf-8

require "./lib/base"
require  "./lib/text_to_stock"
require  "./lib/indicator"


class MovingAverage < Indicator
  def initialize(stock, params)
    @stock = stock
    @span = params[:span]
      @price_at = params[:price_at] || :close
  end
  
  def calculate_indicator
    prices = @stock.send(@price_at.to_s + "_prices")
    prices.moving_average(@span)
    
  end
end

#
#tts = TextToStock.new(stock_list: "tosho_list.txt")
#stock = tts.generate_stock(1343)
#
#puts "Original"
#puts stock.close_prices.join(",")
#
#
#ma = MovingAverage.new(stock,span: 10, price_at: :close).calculate
#
#puts "MovingAverage"
#ma.each do |v|
#  next unless v
#  print "#{v},"
#end
#
#puts""