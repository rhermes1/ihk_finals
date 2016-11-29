#!/usr/bin/env ruby
require_relative 'lib/vektor.rb'
require_relative 'lib/punkt.rb'

class Stroemungsgebiet
  attr_accessor :punktA, :punktB, :sv, :debug

  def initialize(start, ende, sv, debug=false)
    @debug = debug
    if (start <= ende) then
      @punktA = start
      @punktB = ende
    else
      @punktA = ende
      @punktB = start
    end
    @sv = sv
    dputs("Initialize finished: #{self}")
  end
  
  def ==(other)
    return (@punktA == other.punktA and @punktB == other.punktB)
  end

  def dputs(string)
    puts string if @debug
  end

  def to_s
    "Stroemungsgebiet von #{@punktA} bis #{@punktB} mit SV #{@sv}"
  end
end
