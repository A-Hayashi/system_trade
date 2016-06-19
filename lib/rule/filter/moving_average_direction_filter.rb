# coding: utf-8

require "./lib/base"

class MovingAverageDirectionFilter < Filter
  def initialize(params)
    @span = params[:span]
  end

  def calculate_indicators
    @moving_average_direction =
    MovingAverageDirection.new(@stock,span: @span).calculate
  end

  def filter(index)
    case @moving_average_direction[index-1]
    when :up
      :long_only
    when :down
      :short_only
    when :flat
      :no_entry
    end
  end

end