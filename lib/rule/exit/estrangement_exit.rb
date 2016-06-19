# coding: utf-8

require "./lib/base"

class EstrangementExit < Exit
  def initialize(params)
    @span = params[:span]
    @rate = params[:rate]

  end

  def calculate_indicators
    @estrangement = Estrangement.new(@stock, span: @span).calculate
  end

  def check_long(index)
    if @estrangement[index-1] > (-1)*@rate
      exit(trade,index,@stock.open_prices[index], :open)
    end
  end

  def check_short(index)
    if @estrangement[index-1] < @rate
      exit(trade,index,@stock.open_prices[index], :open)
    end
  end
end