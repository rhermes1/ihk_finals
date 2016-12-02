#!/usr/bin/env ruby
require_relative "../models/seegebiet"
require "test/unit"
 
class TestSeegebiet < Test::Unit::TestCase
  def setup
    @st_cfg = [
      ["0", "0", "15", "25", "1.79", "0.894"],
      ["15", "10", "25", "30", "3.0", "0.0"],
      ["25", "30", "15", "10", "8.0", "2.0"],
      ["15", "0", "35", "10", "2.121", "-2"],
    ]
  end

  def test_creaete_seegebiet
    p1 = Punkt.new(0, 0)
    p2 = Punkt.new(40, 40)
    sg = Seegebiet.new(p2, p1, @st_cfg)
    assert_equal(p1, sg.punktA)
    assert_equal(p2, sg.punktB)
    assert_equal(4, sg.stroemungsgebiete.length)

    assert_equal(sg.stroemungsgebiete.first.sv.x, 0)
    assert_not_equal(sg.stroemungsgebiete[2].sv.x, 3.0)
    assert_equal(sg.stroemungsgebiete.last.sv.x, 2.121)
  end
end
