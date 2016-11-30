#!/usr/bin/env ruby

class Gerade
  attr_accessor :p1, :p2, :m, :b, :ungerade

  def initialize(p1, p2)
    return unless (p1.class == Punkt and p2.class == Punkt)
    @p1 = p1
    @p2 = p2
    if(@p1.x == @p2.x) then
      @ungerade = true
      @m = @p1.x
      @b = @p1.y
    else
      @ungerade = false
      @m = (@p2.y - @p1.y).to_f / (@p2.x - @p1.x).to_f
      @b = (@p2.y - @m*p2.x).to_f
    end
  end

  def funktion(x)
    return (@p1.y) if @ungerade
    return (@m*x+@b).round(2)
  end
  
  def has_y?(y)
    if(@p1.y > @p2.y) then
      return y.between?(@p2.y, @p1.y)
    else
      return y.between?(@p1.y, @p2.y)
    end
  end

  def has_x?(x)
    if(@p1.x > @p2.x) then
      return x.between?(@p2.x, @p1.x)
    else
      return x.between?(@p1.x, @p2.x)
    end
  end

  def has_point?(p)
    if @ungerade then
      return (has_x?(p.x) and has_y?(p.y))
    else
      return (has_y?(funktion(p.x)) and has_x?(p.x))
    end
  end

  # 2 intersect
  # 1 identisch
  # 0 parallel
  def intersect?(other)
    return 2 unless (@m == other.m)# intersect
    return 2 if not (@p1.x == other.p1.x and @p2.x == other.p2.x)
    return (has_point?(other.p1) or has_point?(other.p2)) ? 1 : 0
  end

  def intersection_point(other)
    return nil unless(intersect?(other) == 2)
    tmp_x, tmp_y = nil
    if(@ungerade and other.ungerade) then
      tmp_x, tmp_y = @p1.x, other.p1.y
    elsif(@ungerade)
      tmp_x, tmp_y = @p1.x, other.funktion(@p1.x)
    elsif(other.ungerade)
      tmp_x, tmp_y = other.p1.x, funktion(other.p1.x)
    else
      tmp_x = (@b - other.b).to_f / (other.m - @m).to_f unless tmp_x
      tmp_y = funktion(tmp_x)
    end
    ip = Punkt.new(tmp_x, tmp_y)
    return ip if(has_point?(ip) and other.has_point?(ip))
    return nil
  end

  def to_s
    "Gerade von #{@p1} bis #{@p2} mit M #{@m}"
  end
end
