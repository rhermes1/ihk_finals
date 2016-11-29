#!/usr/bin/env ruby
require_relative 'lib/vektor.rb'
require_relative 'lib/punkt.rb'
require_relative 'stroemungsgebiet'

class Seegebiet
  attr_accessor :punktA, :punktB, :stroemungsgebiete, :debug

  def dputs(string)
    puts string if @debug
  end

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
    add_stroemung(start, ende, Vektor.new(1, 1))
    initializiere_stroemungen(stroemung_cfg)
    dputs("Initialize finished: #{self}")
  end

  def add_stroemung(pkt_a, pkt_b, sv)
    if(is_v?(pkt_a) and is_v?(pkt_b)) then
      new_sg = Stroemungsgebiet.new(pkt_a, pkt_b, sv)
      @stroemungsgebiete.each do |sg|
        if (new_sg == sg) then
          sg.sv = new_sg.sv
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
      if(s_cfg.length == 6) then
        pktA = Punkt.new(s_cfg[0], s_cfg[1])
        pktB = Punkt.new(s_cfg[2], s_cfg[3])
        sv = Vektor.new(s_cfg[4], s_cfg[5])
        add_stroemung(pktA, pktB, sv)
      else
        dputs("ERROR: Not enough arguments for Stroemung!")
      end
    end
    dputs("Initialize Stroemungen finished")
  end

  def is_v?(punkt)
    return (punkt <= @punktB && punkt >= @punktA)
  end

  def to_s
    "Seegebiet von #{@punktA} bis #{@punktB}"
  end
end
