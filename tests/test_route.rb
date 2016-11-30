#!/usr/bin/env ruby
require_relative "../route"
require_relative "../seegebiet"
require "test/unit"
 
class TestRoute < Test::Unit::TestCase
  def setup
    @p1 = Punkt.new(0, 0)
    @p2 = Punkt.new(40, 40)
  end

  def test_create_route
    sg = Seegebiet.new(@p1, Punkt.new(50, 50), [])
    route = Route.new(@p2, @p1, sg)

    assert_equal(@p1, route.ende)
    assert_equal(@p2, route.start)
  end

  def test_expected_teilstuecke
    sg = Seegebiet.new(@p1, Punkt.new(50, 50), [])
    route = Route.new(@p2, @p1, sg)

    route.berechne_route
    assert_equal(1, route.ts.length)
  end
end
