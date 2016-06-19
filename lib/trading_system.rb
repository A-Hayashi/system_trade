# coding: utf-8

class TradingSystem
  def initialize(rules = {})
    @entries = [rules[:entries]].flatten.compact
    @exits = [rules[:exits]].flatten.compact
    @stops = [rules[:stops]].flatten.compact
    @filters = [rules[:filters]].flatten.compact
  end

  def set_stock(stock)
    each_rules do |rule|
      rule.stock = stock
    end
  end

  def calculate_indicators
    each_rules{|rule| rule.calculate_indicators}
  end

  def check_entry(index)
    trade = entry_through_filter(index)
    return unless trade
    trade_with_first_stop(trade, index)
  end

  def set_stop(position, index)
    position.stop = tightest_stop(position, index)

  end

  def check_exit(trade, index)
    @exits.each do |exit_rule|
      exit_filter = exit_rule.check_exit(trade, index)
      return if exit_filter == :no_exit
      return if trade.closed?
    end
  end

  private

  def each_rules
    [@entries, @exits, @stops, @filters].flatten.each do |rule|
      yield rule
    end
  end

  def entry_through_filter(index)
    case filter_signal(index)
    when :no_entry
      nil
    when :long_and_short
      check_long_entry(index) || check_short_entry(index)
    when :long_only
      check_long_entry(index)
    when :short_only
      check_short_entry(index)
    end
  end

  def filter_signal(index)
    filters = @filters.map{|filter| filter.get_filter(index)}
    return :no_entry if filters.include?(nil) ||
    filters.include?(:no_entry) ||
    (filters.include?(:long_only) &&
    filters.include?(:short_only))

    return :long_only if filters.include?(:long_only)
    return :short_only if filters.include?(:short_only)
    :long_and_short
  end

  def check_long_entry(index)
    check_entry_rule(:long, index)
  end

  def check_short_entry(index)
    check_entry_rule(:short, index)
  end

  def check_entry_rule(long_short, index)
    @entries.each do |entry|
      entry
      trade = entry.send("check_#{long_short}_entry", index)
      return trade if trade
    end
    nil
  end

  def tightest_stop(position, index)
    stops = [position.stop]+
    @stops.map{|stop| stop.get_stop(position, index)}

    stops.compact!

    if position.long?
      stops.max
    elsif position.short?
      stops.min
    end
  end

  def trade_with_first_stop(trade, index)
    return trade if @stop.empty?
    stop = tightest_stop(trade, index)

    return unless stop
    trade.first_stop = stop
    trade.stop = stop
  end
end
