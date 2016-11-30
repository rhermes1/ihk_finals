#!/usr/bin/env ruby
require_relative 'lib/vektor.rb'
require_relative 'lib/punkt.rb'
require_relative 'teilstueck'

class Route
  attr_accessor :start, :ende, :ts, :debug, :seegebiet

  def initialize(start, ende, seegebiet, debug=false)
    @start = start
    @ende = ende
    @debug = debug
    @seegebiet = seegebiet
    @ts = []
    dputs("Initialize finished: #{self}")
  end

  def dputs(string)
    puts string if @debug
  end

  def berechne_route
    dputs("Start calculating Route")
    berechne_teilstuecke(@start, @ende)
  end

  def berechne_teilstuecke(start, ende)
    ipc, ipv = @seegebiet.get_teilstueck(start, ende).first
    @ts << Teilstueck.new(start, ipc, ipv)
    if(ipc != ende) then
      berechne_teilstuecke(ipc, ende)
    end
  end

  def to_s
    "Route von #{start} nach #{ende}"
  end
end
