# coding: utf-8

require "./lib/array"

class Indicator
  include Enumerable
  def initialize(stock)
    @stock = stock
  end

  def each
    @indicator.each {|value| yield value}
  end

  def [](index)
    if index.kind_of? Numeric and
    (@indicator[index].nil? or index < 0)
      throw :no_value
    else
      @indicator[index]
    end
  end

  def calculate
    @indicator = calculate_indicator
    self
  end

  def calculate_indicator

  end
end

#class MyIndicator < Indicator
#  def calculate_indicator
#    [nil, nil, 3, 5, 8, 4]
#  end
#end
#
#my_indicator = MyIndicator.new(nil).calculate
#
#my_indicator.each do |ind|
#  p ind
#end
#
#puts
#puts my_indicator.first
#puts my_indicator[2]
#puts my_indicator[3]
#puts
#
#catch(:no_value) do
#  puts my_indicator[0]
#end
#
#puts
#
#(0..5).each do |i|
#  catch(:no_value) do
#    puts my_indicator[i]
#  end
#end
#
#p my_indicator[0..2]
#p my_indicator[2..4]