#!/usr/bin/env ruby

class Vektor
  attr_accessor :kmh
  @@point = nil

  def initialize(x, y, kmh = 1)
    if (x.class.to_s == "Punkt" && y.class.to_s == "Punkt") then
      @@point = y - x
    else
      raise ArgumentError.new("Expect two valid Points for x and y")
    end
    @kmh = kmh
  end

  def norm
    norm_v = @kmh / self.scalar
    @@point *= norm_v
  end

  def x
    @@point.x
  end

  def y
    @@point.y
  end

  def scalar
    return Math.sqrt((x**2)+(y**2))
  end

  def to_s
    "#{@x}:#{@y}"
  end
end
