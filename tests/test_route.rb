#!/usr/bin/env ruby
require_relative "../models/route"
require_relative "../models/seegebiet"
require "test/unit"
 
class TestRoute < Test::Unit::TestCase
  def setup
    @p1 = Punkt.new(0, 0)
    @p2 = Punkt.new(40, 40)
  end

  def test_create_route
    sg = Seegebiet.new(@p1, Punkt.new(50, 50), [])
    route = Route.new(sg)

    assert_equal(0, route.ts.length)
  end

  def test_expected_teilstuecke
    sg = Seegebiet.new(@p1, Punkt.new(50, 50), [])
    route = Route.new(sg)

    route.berechne_route(@p1, @p2)
    assert_equal(1, route.ts.length)
  end
end
