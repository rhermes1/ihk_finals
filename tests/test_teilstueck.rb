#!/usr/bin/env ruby
require_relative "../models/teilstueck"
require_relative "../lib/punkt"
require_relative "../lib/vektor"
require "test/unit"
 
class TestTeilstueck < Test::Unit::TestCase
  def setup
    @start = Punkt.new(3, 1)
    @ende = Punkt.new(11, 5)
    @sv = Vektor.new(1.109, -1.664)
  end

  def test_teilstueck
    ts = Teilstueck.new(@start, @ende, @sv)

    assert_equal(8.9, ts.dist)
    assert_equal(5.1, ts.kmh)
    assert_equal(1.7, ts.time)
  end
end
