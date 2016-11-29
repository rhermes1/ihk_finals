#!/usr/bin/env ruby
require_relative 'lib/vektor.rb'
require_relative 'lib/punkt.rb'

class Stroemungsgebiet
  attr_accessor :punktA, :punktB, :sv

  def initialize(start, ende, sv)
    if (start <= ende) then
      @punktA = start
      @punktB = ende
    else
      @punktA = ende
      @punktB = start
    end
    @sv = sv
  end
  
  def ==(other)
    return (@punktA == other.punktA and @punktB == other.punktB)
  end

  def to_s
    "Stroemungsgebiet von #{@punktA} bis #{@punktB} mit SV #{@sv}"
  end
end
