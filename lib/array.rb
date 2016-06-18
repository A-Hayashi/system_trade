# coding: utf-8

class Array
  def sum
    self.inject(:+)
  end

  def average
    sum.to_f / self.size
  end

  def map_indicator(span)
    indicator_array = Array.new(self.size)
    self.each_cons(span).with_index do |span_array, index|

      next if span_array.include?(nil)
      indicator_array[index+span-1] = yield span_array
    end
    indicator_array
  end

  def moving_average(span)
    map_indicator(span) {|vals| vals.average}
  end

  def highs(span)
    map_indicator(span) {|vals| vals.max}
  end

  def lows(span)
    map_indicator(span) {|vals| vals.min}
  end

end
#
#
#a = [10,15,13,14,20]
#
#p a.moving_average(2)
#p a.highs(3)
#p a.lows(3)
#
#p b = a.moving_average(2)
#p b.highs(3)
#p b.lows(3)
#
#
#
#array = [100,97,111,115,116,123,121,119,115,110]
#
#
#
#puts array.sum
#puts array.average
#
#p array.moving_average(4)
#
#p array.highs(3)
#
#p array.lows(3)
#
#middle = array.map_indicator(3) do |vals|
#  (vals.max+vals.min) / 2.0
#end
#
#p middle
#
#changes = array.map_indicator(2) do |vals|
#  vals.last - vals.first
#end
#
#p changes
#
#
#average_changes = changes.moving_average(3)
#p average_changes
#
#
#span = 4
#alpha = 2.0 / (span+1)
#ema = nil
#ema_array = array.map_indicator(span) do |vals|
#  unless ema
#    ema = vals.average
#  else
#    ema += alpha * (vals.last - ema)
#  end
#end
#p ema_array
#
