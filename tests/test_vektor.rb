#!/usr/bin/env ruby
require_relative "../lib/vektor.rb"
require_relative "../lib/punkt.rb"
require "test/unit"
 
class TestVektor < Test::Unit::TestCase
  def setup
    @A = Punkt.new(3, 1)
    @E = Punkt.new(11, 5)
  end

  def test_create_vektor
    a = Vektor.new(@A, @E)
    assert_equal(8, a.x);
    assert_equal(4, a.y);

    a = Vektor.new(7, 1)
    assert_equal(7, a.x);
    assert_equal(1, a.y);
  end

  def test_vektor_scalar_norm
    a = Vektor.new(@A, @E, 5)
    assert_equal(Math.sqrt(80), a.scalar);

    b = a.norm
    assert_equal(4.472, b.x.round(3));
    assert_equal(2.236, b.y.round(3));
  end
end
