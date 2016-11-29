#!/usr/bin/env ruby
require_relative "../lib/punkt.rb"
require "test/unit"
 
class TestPunkt < Test::Unit::TestCase
  def test_punkt_add
    a = Punkt.new(1, 2)
    a += Punkt.new(4, 3)
    assert_equal(5, a.x);
    assert_equal(5, a.y);
  end

  def test_punkt_minus
    a = Punkt.new(1, 2)
    a -= Punkt.new(4, 3)
    assert_equal(-3, a.x);
    assert_equal(-1, a.y);
  end

  def test_punkt_multiple
    a = Punkt.new(1, 6)
    a *= 5
    assert_equal(5, a.x)
    assert_equal(30, a.y)
  end
end
