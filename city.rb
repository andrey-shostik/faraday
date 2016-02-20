require 'faraday'
require 'json'

class City
  API_KEY = '1ecd61a1ba5714cdc22ea4ea7f63ed23'
  K = 273.15
  attr_accessor :name

  def initialize(name = 'Kaniv')
    @name = name
  end

  def say_weather
    puts "now weather in #{@name}"
    (conditions['main']['temp']) - K
  end

  private
  def conditions
    if @conditions.nil?
      response = connection.get("/data/2.5/weather?q=#{name.gsub('-','_')},uk&appid=#{API_KEY}")
      @conditions = JSON.parse(response.body)
    else
      @conditions
    end
  end

  def connection
    @connection ||= Faraday.new(url: 'http://openweathermap.org/') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end
end

a = City.new
puts a.say_weather
