#!/usr/bin/ruby
# Simple example script to retrieve the details of the device
# named in DEVICE_ID using the EyeHub API

require 'rubygems'
require 'json'
require 'net/https'

# Change these to match your account and device details
EYEHUB_USERNAME="YOUR_EYEHUB_USERNAME"
EYEHUB_PASSWORD="YOUR_EYEHUB_PASSWORD"
DEVICE_MANAGER_ID="DEVICE_MANAGER_ID"
DEVICE_ID="YOUR_DEVICE_ID"

# First off, let's get the basic info for the device
puts "Get basic device info for #{DEVICE_ID}"
device_uri = URI.parse("https://hub.flexeye.com/v1/iot_Default/dms/#{DEVICE_MANAGER_ID}/devices/#{DEVICE_ID}")
http = Net::HTTP.new(device_uri.host, device_uri.port)
http.use_ssl = true
request = Net::HTTP::Get.new(device_uri.request_uri)
request.basic_auth(EYEHUB_USERNAME, EYEHUB_PASSWORD)
device_data = http.request(request)
# We've got a chunk of JSON data in response, so parse it to let us extract
# some useful bits
device_details = JSON.parse(device_data.body)
# And just output the ID and number of events for now
puts "Device ID: "+device_details["id"]
puts "Display Name: "+device_details["displayName"]
puts "Event count: "+device_details["numEventsAll"].to_s
puts


