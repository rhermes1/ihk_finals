#!/usr/bin/env ruby
require_relative 'lib/vektor.rb'
require_relative 'lib/punkt.rb'
require_relative 'lib/gerade.rb'


#C------B
#|      |
#|      |
#A------D
class Stroemungsgebiet
  attr_accessor :punktA, :punktB, :sv, :debug, :geraden

  def initialize(start, ende, sv, debug=false)
    @debug = debug
    @geraden = []
    @sv = sv
    if (start <= ende) then
      @punktA = start
      @punktB = ende
    else
      @punktA = ende
      @punktB = start
    end
    initialize_geraden

    dputs("Initialize finished: #{self}")
  end
  
  def initialize_geraden
    @punktC = Punkt.new(@punktA.x, @punktB.y)
    @punktD = Punkt.new(@punktB.x, @punktA.y)

    @geraden << Gerade.new(@punktA, @punktC)
    @geraden << Gerade.new(@punktA, @punktD)
    @geraden << Gerade.new(@punktC, @punktB)
    @geraden << Gerade.new(@punktD, @punktB)
  end

  def ==(other)
    return (@punktA == other.punktA and @punktB == other.punktB)
  end

  def has_point?(p)
    return ((p <= @punktB and @punktA <= p) or
      (p <= @punktA and @punktB <= p))
  end

  def dputs(string)
    puts string if @debug
  end

  def get_intersection(start, ende)
    sg = Gerade.new(start, ende)
    iv = Vektor.new(start, ende)
    ip = ende

    return ip if has_point?(start) and has_point?(ende)
    @geraden.each do |g|
      if(g.intersect?(sg)) then
        ip2 = g.intersection_point(sg)
        next if(not ip2 or ip2 == start)
        iv2 = Vektor.new(start, ip2)
        if (iv2.scalar <= iv.scalar) then
          ip = ip2
          iv = iv2
        end
      end
    end

    return ip
  end

  def to_s
    "#{@punktA} #{@punktB} SV = #{@sv}"
  end
end
