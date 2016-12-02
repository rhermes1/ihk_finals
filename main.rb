#!/usr/bin/env ruby
require 'optparse'
require_relative 'models/white_star_line'

options = {}
descriptions = {}
@debug = false

def dputs(string)
  puts string if @debug
end

def read_config(path_file, test=false)
    f = File.new(path_file, "r")
    config_regexs = {
      "Description" => /\w+/,
      "Seegebiet" => /(\d+)\s+(\d+)/,
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
    check_config(configs, test)

    return configs
end

def check_config(configs, test)
  unless(configs["Seegebiet"].flatten.length == 2) then
    puts "Found too many values for Seegebiet. Exit!\nConfig: "
    puts configs["Route"].flatten.join(", ")
    exit 0
  end

  rlength = configs["Route"].flatten.length
  if(!(rlength >= 4) or (rlength % 2) != 0) then
    puts "Routen Punkte config is wrong. Exit!"
    puts configs["Route"].flatten.join(", ")
    exit 0
  end

  scfgs = configs["Stroemungen"]
  scfgs.each do |scfg|
    if (scfg.length != 4 and scfg.length != 6) then
      puts "Stroemungen config is wrong. Exit!\nConfig: "
      puts scfg.join(", ")
      exit 0
    end
  end
end

def create_whitestar_line_from_config(cfg_path)
  if(!cfg_path or File.directory?(cfg_path)) then
    puts "No valid Input file given. Got: '#{cfg_path}'. Exit!"
    exit 0 
  end
  configs = read_config(cfg_path)
  configs["verbose"] = @debug
  return [WhiteStarLine.new(configs), configs["Description"].join(" ")]
end

def execute_all_tests()
  Dir.foreach('./tests/') do |test_file|
    next if [".", ".."].include?(test_file) or File.directory?(test_file)
    dputs("\nExecute Test #{test_file}\n")
    system("ruby ./tests/#{test_file}")
  end

  test_path_dir = './tests/test_config_files/'
  dputs("\nExecute test_config_files from #{test_path_dir}\n")

  Dir.foreach(test_path_dir) do |test_file|
    next if [".", ".."].include?(test_file) or File.directory?(test_file)
    next if test_file.match(/\.out$/)

    dputs("\nCreate WSL with config from #{test_file}\n")
    wsl, desc = create_whitestar_line_from_config(test_path_dir + test_file)
    sep = "*" * desc.length + "\n"
    puts sep + desc + "\n" + sep + wsl.to_s
  end
end

def execute_whitestar_line(input, output="")

  wsl, description = create_whitestar_line_from_config(input)
  sep = "*" * description.length + "\n"
  out_str = sep + description + "\n" + sep + wsl.to_s

  if(output) then
    open(output, 'w') { |f|
        f.puts out_str
    }
  else
     puts out_str
  end
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

  opts.on("-t", "--test", "Executes all tests in 'tests/'") do |t|
    options[:tests] = t
  end
end.parse!

if(options[:tests]) then
  dputs("Execute all tests!")
  execute_all_tests()
else
  execute_whitestar_line(options[:in_file], options[:out_file])
end

