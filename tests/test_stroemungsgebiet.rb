#!/usr/bin/env ruby
require_relative "../models/stroemungsgebiet"
require "test/unit"
 
class TestStroemungsgebiet < Test::Unit::TestCase
  def test_creaete_stroemungsgebiet
    p1 = Punkt.new(0, 0)
    p2 = Punkt.new(40, 40)
    sg = Stroemungsgebiet.new(p2, p1, Vektor.new(1, 1))
    sg2 = Stroemungsgebiet.new(p1, p2, Vektor.new(3,4))

    assert_equal(p1, sg.punktA)
    assert_equal(p2, sg.punktB)
    assert_equal(sg, sg2)
  end
end
