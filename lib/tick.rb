# coding: utf-8

module Tick
  module_function
  
  def size(price)
    if price <= 3000
      1
    elsif 3000 < price && price <=5000
      5
    elsif 5000 < price && price <= 30000
      10
    elsif 30000 < price && price <= 50000
      50
    elsif 50000 < price && price <= 300000
      100
    elsif 300000 < price && price <= 500000
      500
    elsif 500000 < price && pygrice <= 3000000
      1000
    elsif 3000000 < price && price <= 5000000
      5000
    elsif 5000000 < price && price <= 30000000
      10000
    elsif 30000000 < price && price <= 50000000
      50000
    elsif 50000000 < price
      100000

    end
  end

  def ceil(price)
    tick_size = size(price)
    if price % tick_size == 0
      price
    else
      truncate(price) + tick_size
    end
  end

  def truncate(price)
    (price - price % size(price)).truncate
  end

  def round(price)
    tick_size = size(price)
    if price % tick_size * 2 >= tick_size
      ceil(price)
    else
      truncate(price)
    end
  end

  def up(price, tick = 1)
    tick.times {price += size(price)}
    ceil(price)
  end

  def down(price, tick=1)
    price = truncate(price)
    tick.times {price -= size(price) }
    price
  end

end




puts Tick.size(100)
puts Tick.size(2999)
puts Tick.size(3000)
puts Tick.size(3001)
puts Tick.size(4000)
puts Tick.size(5100)
puts Tick.size(30000)
puts Tick.size(30050)
puts

puts Tick.truncate(99.99)
puts Tick.truncate(3004)
puts Tick.truncate(3006)
puts
puts Tick.ceil(99.99)
puts Tick.ceil(3004)
puts Tick.ceil(3006)
puts
puts Tick.round(99.99)
puts Tick.round(99.49)
puts Tick.round(3004)
puts Tick.round(3002)
puts
puts Tick.up(100)
puts Tick.up(100,3)
puts Tick.up(2999,1)
puts Tick.up(2999,2)
puts Tick.up(3000)
puts
puts Tick.down(100)
puts Tick.down(100,3)
puts Tick.down(3005,1)
puts Tick.down(3005,2)
puts Tick.down(3000)
puts Tick.down(3001)