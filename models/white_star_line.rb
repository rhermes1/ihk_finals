#!/usr/bin/env ruby
require_relative '../lib/vektor.rb'
require_relative '../lib/punkt.rb'
require_relative 'route.rb'
require_relative 'seegebiet.rb'

class WhiteStarLine
  attr_accessor :seegebiet, :route, :zielpunkte, :debug

  def dputs(string)
    puts string if @debug
  end

  def initialize(config)
    @debug = config["verbose"]
    @zielpunkte = []
    initialize_seegebiet(config)
    initialize_route(config)
    berechne_routen
  end

  def berechne_routen
    @zielpunkte.each_with_index do |pkt, index|
      pkt2 = @zielpunkte[index+1]
      if(pkt and pkt2) then
        @route.berechne_route(pkt, pkt2)
      end
    end
  end

  def initialize_seegebiet(config)
    return unless config["Seegebiet"]
    cfg = config["Seegebiet"].flatten()
    @seegebiet = Seegebiet.new(Punkt.new(0, 0), Punkt.new(cfg[0],
      cfg[1]), config["Stroemungen"], @debug)
  end

  def initialize_route(config)
    return unless config["Route"]
    cfg = config["Route"].flatten().each_slice(2).to_a
    @route = Route.new(@seegebiet, @debug)
    cfg.each do |pkt|
      pkt1 = Punkt.new(pkt[0], pkt[1])
      if(@seegebiet.is_v?(pkt1)) then
        @zielpunkte << pkt1
      else
        dputs("ERROR: #{pkt1} is out of Seegebiet range")
      end
    end
  end

  def to_s
    @seegebiet.to_s +
    "\n\nzu fahrende Route\n" +
    @zielpunkte.each_with_index.map {|a,i| " Punkt #{i}: #{a}\n" }.join("\n") +
    @route.to_s
  end
end
