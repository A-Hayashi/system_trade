# coding: utf-8

class Trade
  attr_accessor :stock_code, :trade_type, :entry_date,
  :entry_price, :entry_time, :volume, :exit_date,
  :exit_price, :exit_time, :length, :first_stop, :stop
  def initialize(params)
    @stock_code = params[:stock_code]
    @trade_type = params[:trade_type]
    @entry_date = params[:entry_date]
    @entry_price = params[:entry_price]
    @volume = params[:volume]
    @entry_time = params[:entry_time]
    @length = 1
  end

  def exit(params)
    @exit_date = params[:exit_date] || params[:date]
    @exit_price = params[:exit_price] || params[:price]
    @exit_time = params[:exit_time] || params[:time]

  end

  def closed?
    if @exit_date && @exit_price
      true
    else
      false
    end
  end

  def long?
    @trade_type == :long
  end

  def short?
    @trade_type == :short
  end

  def profit
    plain_result * @volume
  end

  def percentage_result
    (plain_result.to_f / @entry_price) * 100
  end

  def r
    return unless @first_stop
    if long?
      @entry_price - @first_stop
    elsif short?
      @first_stop - @entry_price
    end
  end

  def r_multiple
    return unless @first_stop
    return if r==0
    plain_result.to_f / r.to_f
  end

  private

  def plain_result
    if long?
      @exit_price - @entry_price
    elsif short?
      @entry_price - @exit_price
    end
  end
end

#trade = Trade.new(stock_code: 8604,
#                  trade_type: :long,
#                  entry_date: "2011/11/14",
#                  entry_price: 251,
#                  entry_time: :open,
#                  volume: 100)
#                  
#puts trade.stock_code()
#puts trade.entry_date()
#puts trade.entry_price()
#puts trade.long?()
#puts trade.short?()
#puts trade.closed?()
#
#trade.first_stop = 241
#trade.stop = 241
#trade.length = 1
#
#puts trade.first_stop
#puts trade.stop
#puts trade.r
#puts trade.length
#
#trade.length +=1
#
#puts trade.length()
#
#trade.exit(date: "2011/11/15",
#            price: 255,
#            time: :in_session)
#            
#puts trade.closed?()
#puts trade.exit_date
#puts trade.profit()
#puts trade.percentage_result
#puts trade.r_multiple()

