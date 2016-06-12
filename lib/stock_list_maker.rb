# coding: utf-8

require "open-uri"

class StockListMaker
  attr_accessor:data_dir, :file_name
  def initialize(market)
    @market = market
    @data_dir = "data"
    @stock_info = []
  end

  def get_stock_info(code)
    page = open_page(code)
    return unless page
    text = page.read.encode(Encoding::UTF_8 ,:undef => :replace)
    data = parse(text)
    data[:code] = code
    return unless data[:market_selection]
    p data
    puts code
    @stock_info << data
  end

  def save_stock_list
    File.open(@data_dir + "/" + @file_name, "w:utf-8") do |file|
      @stock_info.each do |data|
        file.puts [data[:code], data[:market_selection],
          data[:unit]].join(",")
      end
    end
  end

  private

  def open_page(code)
    begin
      open("http://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{code}.#{@market}")
    rescue OpenURI::HTTPError
      return
    end
  end

  def parse(text)
    data = Hash.new
    sections = []
    reg_market = %r!<span class="stockMainTabName">(.+?)</span>!
    reg_unit = %r!<dd class="ymuiEditLink mar0"><strong>(.+?)</strong>株</dd>!
    text.lines do |line|
      if line =~ reg_market
        sections << $+
      elsif line =~ reg_unit
        data[:market_selection] = sections[0]
        data[:unit] = get_unit($+)
        return data
      end
    end
    data
  end

  def get_unit(str)
    if str == "---"
      "1"
    else
      str.gsub(/,/,"")
    end
  end
end

#a = StockListMaker.new(:t)
#(1854..2000).each do |code|
#  a.get_stock_info(code)
#end

