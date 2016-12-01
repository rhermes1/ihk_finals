#!/usr/bin/env ruby
require_relative '../lib/vektor.rb'
require_relative '../lib/punkt.rb'
require_relative 'stroemungsgebiet'

class Seegebiet
  attr_accessor :punktA, :punktB, :stroemungsgebiete, :debug

  def initialize(start, ende, stroemung_cfg, verbose=false)
    @debug = verbose
    @stroemungsgebiete = []
    if (start <= ende) then
      @punktA = start
      @punktB = ende
    else
      @punktA = ende
      @punktB = start
    end
    dputs("Initialize finished: #{self}")
    add_stroemung(start, ende, Vektor.new(0, 0))
    initializiere_stroemungen(stroemung_cfg)
  end

  def add_stroemung(pkt_a, pkt_b, sv)
    if(is_v?(pkt_a) and is_v?(pkt_b)) then
      new_sg = Stroemungsgebiet.new(pkt_a, pkt_b, sv, @debug)
      @stroemungsgebiete.each do |sg|
        if (new_sg == sg) then
          sg.sv= new_sg.sv
          new_sg = nil
          dputs("INFO: Overwrite old sv.\nNew: #{sg}")
        end
      end
      @stroemungsgebiete << new_sg if new_sg
    else
      dputs("ERROR: A #{pkt_a} or B #{pkt_b} is out of range!")
    end
  end

  def initializiere_stroemungen(cfg)
    cfg.each do |s_cfg|
      if(s_cfg.length.between?(4, 6)) then
        pktA = Punkt.new(s_cfg[0], s_cfg[1])
        pktB = Punkt.new(s_cfg[2], s_cfg[3])
        sv = s_cfg.length == 6 ? Vektor.new(s_cfg[4], s_cfg[5]) : Vektor.new(0, 0)
        add_stroemung(pktA, pktB, sv)
      else
        dputs("ERROR: Not enough arguments for Stroemung!")
      end
    end
  end

  def erfasse_teilstueck(start, ende)
    dputs("Look for Teilstueck between #{start} : #{ende}")
    dist, ip = Vektor.new(start, ende).scalar, ende

    @stroemungsgebiete.each do |sg|
      dputs("-Check: #{sg}")
      ip2 = sg.get_intersection(start, ende)
      dist2 = Vektor.new(start, ip2).scalar

      if (dist <= dist2 and sg.has_point?(ip)) or (dist2 <= dist) then
        dputs("--new Teilstueck from #{start} to #{ip2}")
        ip, dist = ip2, dist2
      end
    end

    sv = @stroemungsgebiete.reduce(Vektor.new(0, 0)) do |acc, sg|
      acc = sg.sv if (sg.has_point?(start) and sg.has_point?(ip))
      acc
    end

    return [ip, sv]
  end

  def dputs(string)
    puts string if @debug
  end

  def is_v?(punkt)
    return (punkt <= @punktB and punkt >= @punktA)
  end

  def to_s
    "Groesse des Gebietes\n #{@punktB.x} #{@punktB.y}" +
      "\n\nStroemungen\n " + @stroemungsgebiete.join("\n\n ")

  end
end
