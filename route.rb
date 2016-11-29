#!/usr/bin/env ruby
require_relative 'lib/vektor.rb'
require_relative 'lib/punkt.rb'
require_relative 'teilstueck'

class Route
  attr_accessor :start, :ende, :ts, :debug

  def initialize(start, ende, debug=false)
    @start = start
    @ende = ende
    @debug = debug
    dputs("Initialize finished: #{self}")
  end

  def dputs(string)
    puts string if @debug
  end

  def to_s
    "Route von #{start} nach #{ende}"
  end
end
