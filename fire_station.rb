require 'httparty'
require 'pry'

class FireStation
  def initialize
    response = HTTParty.get("https://data.cityofnewyork.us/resource/hc8x-tcnd.json?borough=manhattan&facilityname=Marine%201")
    puts "json: #{response.body}"
    puts "ruby: #{JSON.parse(response.body)}"
  end
end
firestation = FireStation.new
binding.pry
