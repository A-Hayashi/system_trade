# coding: utf-8

require "./lib/base"

class AverageTrueRange < Indicator
  def initialize(stock, params)
    @stock = stock
    @span = params[:span]
  end

  def calculate_indicator
    true_range = @stock.prices.map_indicator(2) do |prices|
      previous_close = prices.first[:close]
      current_high = prices.last[:high]
      current_low = prices.last[:low]
      true_high = [previous_close, current_high].max
      true_low = [previous_close, current_low].min
      true_high - true_low
    end
    true_range.moving_average(@span)
  end
end