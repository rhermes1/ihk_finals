#!/usr/bin/env ruby
require_relative 'lib/vektor.rb'
require_relative 'lib/punkt.rb'
require_relative 'teilstueck'

class Route
  attr_accessor :start, :ende, :ts, :debug, :seegebiet

  def initialize(seegebiet, debug=false)
    @debug = debug
    @seegebiet = seegebiet
    @ts = []
    dputs("Initialize finished: #{self}")
  end

  def dputs(string)
    puts string if @debug
  end

  def berechne_route(start, ende)
    @start, @ende = start, ende
    dputs("Start calculating Route from #{@start} to #{@ende}")
    berechne_teilstuecke(@start, @ende)
  end

  def berechne_teilstuecke(start, ende)
    ipc, ipv = @seegebiet.get_teilstueck(start, ende)
    @ts << Teilstueck.new(start, ipc, ipv)
    if(ipc != ende) then
      berechne_teilstuecke(ipc, ende)
    end
  end

  def to_s
    if @ts.empty? then
      return "Route von #{@start} bis #{@ende}"
    else
      return "\n\nDaten fuer die Planung der Route:\n " + @ts.join("\n\n ")
    end
  end
end
