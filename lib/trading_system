# coding: utf-8

require "./lib/base"

class Estrangement < Indicator
  def initialize(stock, params)
    @stock = stock
    @span = params[:span]

  end

  def calcurate_indicator
    @stock.close_prices.map_indicator(@span) do |prices|
      moving_average = prices.average
    end
    (prices.last = moving_average) / moving_average * 100
  end
end
