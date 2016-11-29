#!/usr/bin/env ruby
require 'optparse'
require_relative 'white_star_line'

options = {}
descriptions = {}
@debug = false

def dputs(string)
  puts string if @debug
end

def read_config(path_file)
    f = File.new(path_file, "r")
    config_regexs = {
      "Description" => /\w+/,
      "Gebietes" => /(\d+)\s+(\d+)/,
      "Route" => /\d+/,
      "Stroemungen" => /([\d\.\-]+)\s*/,
    }
    needed_configs = config_regexs.keys
    fc = needed_configs.shift

    configs = f.reduce({fc => []}) do |acc, row|
      if(row =~ /^;\s*(\w+\s)+/) then
        unless(acc[fc].empty?) then
          fc = needed_configs.shift
          acc[fc] = []
        end
      end
      if(row =~ config_regexs[fc] && acc[fc]) then
        acc[fc] << row.scan(config_regexs[fc]).flatten()
      end
      acc
    end
    f.close

    unless(needed_configs.empty?) then
      puts "Couldn't find all needed Config"
      puts "Check the Order and Completeness. Needed:"
      puts config_regexs.keys.join("\n")
      exit 0
    end

    return configs
end

OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on("-v", "--verbose", "Run verbosely") do |v|
    options[:verbose] = v
    @debug = true
  end

  opts.on("-i", "--input [FILE]", String, "Defines Input file is necessary") do |f|
    options[:in_file] = f
  end

  opts.on("-o", "--output [FILE]", String, "Defines the Output file. Default is STDOUT") do |f|
    options[:out_file] = f
  end
end.parse!

if (!options[:in_file] or !File.exist?(options[:in_file])) then
  if(options[:in_file]) then
    puts "Can't find Input File: '#{options[:in_file]}'. Exit!"
  else
    puts "No Input File given. Exit!"
  end
  exit 0
end

configs = read_config(options[:in_file])
dputs "Found following Config from '#{options[:in_file]}'"
configs.keys.each do |key|
  dputs "\nConfig for #{key}"
  configs[key].each { |c| dputs c.join(" ") }
end

wsl = WhiteStarLine.new(configs)
