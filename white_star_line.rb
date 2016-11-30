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
    @routen = []
    initialize_seegebiet(config)
    initialize_routen(config)
    berechne_routen
  end

  def berechne_routen
    @routen.each do |r|
      r.berechne_route
    end
  end

  def initialize_seegebiet(config)
    cfg = config["Seegebiet"].flatten()
    @seegebiet = Seegebiet.new(Punkt.new(0, 0), Punkt.new(cfg[0],
      cfg[1]), config["Stroemungen"], @debug)
  end

  def initialize_routen(config)
    cfg = config["Route"].flatten().each_slice(2).to_a
    cfg.each_with_index do |ko, index|
      ko2 = cfg[index+1]
      if (ko and ko2) then
        pkt1 = Punkt.new(ko[0], ko[1])
        pkt2 = Punkt.new(ko2[0], ko2[1])
        if(@seegebiet.is_v?(pkt1) and @seegebiet.is_v?(pkt2)) then
          @routen << Route.new(pkt1, pkt2, @seegebiet, @debug)
        end
      end
    end
  end
end
