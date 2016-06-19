# coding: utf-8

require "./lib/base"

class AverageTrueRangeStop < Rule
  def initialize(params)
    @span = params[:span]
    @ratio = params[:ratio] || 1
  end

  def calculate_indicators
    @average_true_range =
    AverageTrueRange.new(@stock, span: @span).calculate
  end

  def stop_price_long(position, index)
    Tick.truncate(position.entry_price - range(index))
  end

  def stop_price_short(position, index)
    Tick.ceil(position.entry_price + range(index))
  end

  private

  def rage(index)
    @average_true_range[index-1]*@ratio
  end
end