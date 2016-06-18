# coding: utf-8

require "./lib/stock"
require "./lib/stock_list_loader"
require "date"

class TextToStock
  attr_writer :from, :to
  def initialize(params)
    @data_dir = params[:data_dir] || "data"
    @stock_list = params[:stock_list] || raise("銘柄リストを選択してください")
    @market_section = params[:market_section]
    @list_loader = StockListLoader.new("#{@data_dir}/#{@stock_list}")
  end

  def generate_stock(code)
    index = @list_loader.codes.index(code)
    stock = Stock.new(code,market(index),@list_loader.units[index])
    add_prices_from_data_file(stock)
    stock
  end

  def each_stock

    @list_loader.filter_by_market_section(*@market_section).codes.each do |code|
      p code
      if File.exist?("#{@data_dir}/#{code}.txt")
        yield generate_stock(code)
      end
    end
  end

  private

  def market(index)
    section = @list_loader.market_sections[index]
    case section
    when /東証|マザーズ/
      :t
    when /名/
      :n
    when /福/
      :f
    when /札/
      :s
    end
  end

  def add_prices_from_data_file(stock)
    lines = File.readlines("#{@data_dir}/#{stock.code}.txt")

    fi = from_index(lines)
    ti = to_index(lines)
    retuen if fi.nil? || ti.nil?
    lines[fi..ti].each do |line|
      data = line.split(",")
      date = data[0]
      prices_and_volume = data[1..5].map{|d| d.to_i}
      stock.add_price(date, *prices_and_volume)
    end

  end

  def from_index(lines)
    return 0 unless @from
    @formatted_from ||=
    Date.parse(@from).to_s.gsub("-","/")
    lines.index{|line| line[0..9] >= @formatted_from}
  end

  def to_index(lines)
    return lines.size unless @to
    @formatted_to ||=
    Date.parse(@to).to_s.gsub("-","/")
    lines.rindex{|line| line[0..9] <= @formatted_to}
  end
end

#
#tts = TextToStock.new(data_dir: "data", stock_list: "tosho_list.txt", market_section: "東証1部")
#stock = tts.generate_stock(1301)
#puts stock.code
#puts stock.dates.first
#puts stock.open_prices.first
#
#tts.each_stock do |stock|
#  puts stock.code
#end
#
#cnt = 0
#tts.each_stock do |stock|
#  puts [stock.code, stock.dates.first, stock.dates.last].join(" ")
#  cnt += 1if !stock.dates.first.nil?
#end
#
#puts cnt