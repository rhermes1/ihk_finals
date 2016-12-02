#!/usr/bin/env ruby

class Teilstueck
  attr_accessor :punktA, :punktB, :sv, :dist, :kmh, :time

  def initialize(start, ende, sv)
    @punktA, @punktB = start, ende
    @rkv = Vektor.new(@punktA, @punktB, 5)
    @sv = sv
    berechne_skv
    berechne_kmh
    berechne_entf
    berechne_dauer
  end

  def berechne_entf()
    @dist = @rkv.scalar.round(1)
  end

  def berechne_kmh()
    return if not @skv
    @kmh = @skv.scalar.round(1)
  end

  def berechne_skv
    return if not (@rkv and @sv)
    @skv = @rkv.norm - @sv
  end

  def berechne_dauer()
    return if not (@dist and @kmh)
    @time = (@dist / @kmh).round(1)
  end

  def to_s
    "Strecke von #{@punktA} nach #{@punktB}\n  Entfernung: #{@dist} km\n  SKV =" +
      " #{@skv}\n  Sollgeschwindigkeit: #{@kmh} km/h\n  Fahrzeit: #{@time} h"
  end
end
