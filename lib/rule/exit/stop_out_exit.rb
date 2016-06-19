# coding: utf-8

require "./lib/base"

class StopOutExit < Exit
  def check_long
    stop = trade.stop
    price = @stock.prices[index]
    return unless stop >= price[:low]
    price, time = if stop >= price[:open]
      [price[:open], :open]
    else
      [stop, :in_session]
    end

    exit(trade, index, price, time)
  end

  def check_short
    stop = trade.stop
    price = @stock.prices[index]
    return unless stop <= price[:high]
    price, time = if stop <= price[:open]
      [price[:open], :open]
    else
      [stop, :in_session]
    end

    exit(trade, index, price, time)
  end

end