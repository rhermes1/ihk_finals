#!/usr/bin/env ruby

class Vektor
  attr_accessor :kmh
  @point = nil

  def initialize(x, y, kmh=1)
    if (x.is_a?(Punkt) && y.is_a?(Punkt)) then
      @point = y - x
    else
      @point = Punkt.new(x, y)
    end
    @kmh = kmh
  end

  def norm
    norm_v = @kmh / self.scalar
    return Vektor.new(x*norm_v, y*norm_v)
  end

  def x
    return @point.x
  end

  def y
    return @point.y
  end

  def -(other)
    return unless other
    return Vektor.new(Punkt.new(other.x, other.y), @point)
  end

  def scalar
    return Math.sqrt((x**2)+(y**2)).to_f
  end

  def to_s
    "(#{x.round(1)};#{y.round(1)})"
  end
end
