#!/usr/bin/env ruby

class Teilstueck
  attr_accessor :punktA, :punktB, :sv

  def initialize(start, ende, sv=Vektor.new(1, 1))
    @punktA, @punktB = start, ende
  end

  def to_s
    "Routen Teilstueck von #{@punktA} bis #{@punktB} mit SV #{sv}"
  end
end
