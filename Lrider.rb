#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'uri'
require 'optparse'

# CTA API information
API_KEY = 'a20132c6acae4519aeef1f89f55a75cc'
BASE_URL = 'http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx'

def fetch_train_routes()
  uri = URI("#{BASE_URL}?key=#{API_KEY}&mapid=41410&outputType=JSON")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  
end

def fetch_station_info()
  uri = URI("#{BASE_URL}?key=#{API_KEY}&mapid=41410&outputType=JSON")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  
end

arrivals = fetch_train_routes()


options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: cta_train_tracker.rb [options]"

  opts.on("-l", "--line LINE", "Specify the train line (e.g., Red, Blue)") do |line|
    options[:line] = line
  end

  opts.on("-s", "--station STATION_ID", "Specify the station ID") do |station_id|
    options[:station_id] = station_id
  end

  opts.on("-h", "--help", "Displays Help") do
    puts opts
    exit
  end
end.parse!

# Ensure the station ID and line are provided
if options[:station_id].nil? || options[:line].nil?
  puts "Error: You must specify both a station ID and a train line."
  puts "Use -h for help."
  exit
end