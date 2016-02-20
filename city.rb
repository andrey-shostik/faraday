require 'faraday'
require 'json'

class City
  API_KEY = '1ecd61a1ba5714cdc22ea4ea7f63ed23'
  attr_accessor :name

  def initialize(name = 'San-Francisco')
    @name = name
  end

  def conditions
    if @conditions.nil?
      response = connection.get("/api/#{API_KEY}/conditions/q/CA/#{name.gsub('-','_')}.json")
      @conditions = JSON.parse(response.body)
      puts @conditions
    else
      @conditions
    end
  end

  private
  def connection
    @connection ||= Faraday.new(url: 'http://api.wunderground.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end
end

a = City.new
a.conditions
