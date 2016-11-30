#!/usr/bin/env ruby
require_relative "../lib/gerade.rb"
require_relative "../lib/punkt.rb"
require "test/unit"
 
class TestGerade < Test::Unit::TestCase
  def setup
    @A = Punkt.new(3, 1)
    @E = Punkt.new(11, 5)
    @g = nil
  end

  def test_create_gerade
    @g = Gerade.new(@A, @E)
    assert_equal(@g.m, 0.5)
    assert_equal(@g.b, -0.5)
  end

  def test_points_on_gerade
    @g = Gerade.new(@A, @E)

    assert_equal(true, @g.has_point?(Punkt.new(8, 3.5)))
    assert_equal(false, @g.has_point?(Punkt.new(1, 0)))
    assert_equal(false, @g.has_point?(Punkt.new(12, 5.5)))
  end

  def test_get_intersection
    g1 = Gerade.new(Punkt.new(0, 0), Punkt.new(10, 5))
    g2 = Gerade.new(Punkt.new(0, 5), Punkt.new(10, 5))
    g3 = Gerade.new(Punkt.new(11, 1), Punkt.new(11, 5))

    assert_equal(2, g1.intersect?(g2))
    assert_equal(2, g1.intersect?(g3))
    assert_equal(Punkt.new(10.0, 5.0), g1.intersection_point(g2))
    assert_equal(nil, g1.intersection_point(g3))
  end
end
