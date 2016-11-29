#!/usr/bin/env ruby
require_relative 'lib/vektor.rb'
require_relative 'lib/punkt.rb'
require_relative 'route.rb'
require_relative 'seegebiet.rb'

class WhiteStarLine
  attr_accessor :seegebiet, :routen, :zielpunkte, :debug

  def dputs(string)
    puts string if @debug
  end

  def initialize(config)
    @debug = config["verbose"]
    initialize_seegebiet(config)
  end

  def initialize_seegebiet(config)
    cfg = config["Seegebiet"].flatten()
    @seegebiet = Seegebiet.new(Punkt.new(0, 0), Punkt.new(cfg[0],
      cfg[1]), config["Stroemungen"], @debug)
  end
end
