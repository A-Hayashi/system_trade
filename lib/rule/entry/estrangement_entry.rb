# coding: utf-8

require "./lib/base"

class EstrangementEntry < Entry
  def initialize(params)
    @span = params[:span]
    @rate = params[:rate]

  end

  def calculate_indicators
    @estrangement = Estrangement.new(@stock, span: @span).calculate
  end

  def check_long(index)
    if @estrangement[index-1] < (-1)*@rate
      enter_long(index,@stock.open_prices[index], :open)
    end
  end

  def check_short(index)
    if @estrangement[index-1] > @rate
      enter_short(index,@stock.open_prices[index], :open)
    end
  end
end