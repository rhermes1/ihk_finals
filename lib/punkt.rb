#!/usr/bin/env ruby

class Punkt
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x.to_f
    @y = y.to_f
  end

  def +(other)
    Punkt.new(@x + other.x, @y + other.y)
  end

  def -(other)
    Punkt.new(@x - other.x, @y - other.y)
  end

  def *(value)
    Punkt.new((@x * value).round(3), (@y * value).round(3))
  end

  def to_s
    "(#{@x.round(3)};#{@y.round(3)})"
  end

  def ==(other)
    return (@x == other.x and @y == other.y)
  end

  def >=(other)
    return (@x >= other.x and @y >= other.y)
  end

  def <=(other)
    return (@x <= other.x and @y <= other.y)
  end

  def <(other)
    return (@x < other.x and @y < other.y)
  end
end
