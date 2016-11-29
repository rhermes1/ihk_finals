#!/usr/bin/env ruby

class Route
  attr_accessor :start, :ende, :ts

  def initialize(start, ende)
    @start = start
    @ende = ende
  end

  def to_s
    "Route von: #{start} nach: #{ende}"
  end
end
