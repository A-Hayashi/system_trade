# coding: utf-8

require "./lib/base"

class Filter < Rule
  def get_filter(index)
    with_valid_indicators{filter(index)}
  end
end