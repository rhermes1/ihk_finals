#!/usr/bin/env ruby

class Punkt
  attr_accessor :x, :y

  def initialize(x, y)
    @x = convert_value(x)
    @y = convert_value(y)
  end

  def convert_value(v)
    if(v.is_a?(String)) then
      if(v.to_f.to_s == v) then
        return  v.to_f
      else
        return v.to_i
      end
    else
      return v
    end
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
    "(#{@x};#{@y})"
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
