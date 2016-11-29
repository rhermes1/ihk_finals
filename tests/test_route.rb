#!/usr/bin/env ruby
require_relative "../route"
require "test/unit"
 
class TestRoute < Test::Unit::TestCase
  def test_create_route
    p1 = Punkt.new(0, 0)
    p2 = Punkt.new(40, 40)
    sg = Route.new(p2, p1)

    assert_equal(p1, sg.punktA)
    assert_equal(p2, sg.punktB)
  end
end
