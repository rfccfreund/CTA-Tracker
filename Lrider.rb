#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'uri'
require 'optparse'

# CTA API information
API_KEY = 'a20132c6acae4519aeef1f89f55a75cc'
BASE_URL = 'http://lapi.transitchicago.com/api/1.0/ttpositions.aspx'

def fetch_train_routes()
  uri = URI("#{BASE_URL}?key=#{API_KEY}&mapid=40300&outputType=JSON")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  
end

result = fetch_train_routes()

puts result
  
  