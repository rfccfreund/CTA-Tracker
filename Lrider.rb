#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'uri'
require 'optparse'
require 'pp'

# CTA API information
API_KEY = 'a20132c6acae4519aeef1f89f55a75cc'
BASE_URL = 'http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx'
BASE_URL_LINES = 'http://lapi.transitchicago.com/api/1.0/ttpositions.aspx'

def fetch_train_routes(line)
  uri = URI("#{BASE_URL_LINES}?key=#{API_KEY}&rt=#{line}&outputType=JSON")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  
end

def fetch_station_info(station)
  uri = URI("#{BASE_URL}?key=#{API_KEY}&mapid=#{station}&outputType=JSON")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: cta_train_tracker.rb [options]"

  opts.on("-l", "--line LINE", "Specify the train line (e.g., Red, Blue)") do |line|
    options[:line] = line
    output = fetch_train_routes(line)
    output.dig('ctatt', 'route', 0, 'train').each do |train|
       pp "Run #{train.dig('rn')} is arriving at #{train.dig('nextStaNm')} at #{train.dig('arrT')}" 
      
    end      
    
  end

  opts.on("-s", "--station STATION_ID", "Specify the station ID") do |station_id|
    options[:station_id] = station_id
    output = fetch_station_info(station_id)
    output.dig('ctatt', 'eta').each do |station|
      pp "#{station.dig('destNm')} bound train's projected arrival time is #{station.dig('arrT')}"
    end
  end

  opts.on("-h", "--help", "Displays Help") do
    puts opts
    exit
  end
end.parse!

# Ensure the station ID and line are provided
# begin if options[:station_id].nil? && options[:line].nil?
#   puts "Error: You must specify both a station ID and a train line."
#   puts "Use -h for help."
#   exit
# end =end