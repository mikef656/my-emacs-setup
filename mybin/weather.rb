# a ruby program pulled together by Al Alexander, http://alvinalexander.com
# thanks to Jay Anderson and many others

require 'rexml/document'
require 'open-uri'
require 'net/smtp'

# yahoo weather url info
# http://developer.yahoo.net/weather/#examples

#Returns a hash containing the location and temperature information
#Accepts US zip codes or Yahoo location id's
def yahoo_weather_query(loc_id, units)
    h = {}
    open("http://xml.weather.yahoo.com/forecastrss?p=#{loc_id}&u=#{units}") do |http|
        response = http.read
        doc = REXML::Document.new(response)
        root              = doc.root
        channel           = root.elements['channel']
        location          = channel.elements['yweather:location']
        h[:city]          = location.attributes["city"]
        h[:region]        = location.attributes["region"]
        h[:country]       = location.attributes["country"]
        h[:temp]          = channel.elements["item"].elements["yweather:condition"].attributes["temp"]
        h[:text]          = channel.elements["item"].elements["yweather:condition"].attributes["text"]
        h[:wind_speed]    = channel.elements['yweather:wind'].attributes['speed']
        h[:humidity]      = channel.elements['yweather:atmosphere'].attributes['humidity']
        h[:sunrise]       = channel.elements['yweather:astronomy'].attributes['sunrise']
        h[:sunset]        = channel.elements['yweather:astronomy'].attributes['sunset']
        h[:forecast_low]  = channel.elements["item"].elements['yweather:forecast'].attributes['low']
        h[:forecast_high] = channel.elements["item"].elements['yweather:forecast'].attributes['high']
    end
    return h       # not cool, i know
end

def get_weather_for_city(city_code,units)
  weather_info = yahoo_weather_query(city_code, units)
  city          = weather_info[:city]
  region        = weather_info[:region]
  country       = weather_info[:country]
  temp          = weather_info[:temp]
  wind_speed    = weather_info[:wind_speed]
  humidity      = weather_info[:humidity]
  text          = weather_info[:text]
  sunrise       = weather_info[:sunrise]
  sunset        = weather_info[:sunset]
  forecast_low  = weather_info[:forecast_low]
  forecast_high = weather_info[:forecast_high]

  return "#{city}, #{region}:\n" +
         "   Currently #{temp} degrees, #{humidity}% humidity, #{wind_speed} mph winds, #{text}.\n" +
         "   Forecast: #{forecast_low} low, #{forecast_high} high.\n" +
         "   Sunrise: #{sunrise}, sunset: #{sunset}.\n"
end

class SendMail < Net::SMTP
  def initialize(options)
      super
      @user     = options["user"]
      @from     = options["from"]
      @to       = options["to"].to_a
      @pass     = options["pass"]
      @server   = options["server"]
      @subject  = options["subject"]
  end

  def body=(mail_body)
      time_foo = Time.new.httpdate
      # BUILD HEADERS
      @body =  "From: #{@from} <#{@from}>\n"
      @body << "To: #{@to}<#{@to}>\n"
      @body << "Subject: #{@subject}\n"
      @body << "Date: #{time_foo}\n"
      @body << "Importance:high\n"
      @body << "MIME-Version:1.0\n"
      @body << "\n\n\n"
      # MESSAGE BODY
      @body << mail_body
  end

  def send
    smtp = Net::SMTP.start(@server, 25)
    smtp.send_message  @body, @from, @to
    smtp.finish
  end
end

##########
#  MAIN  #
##########

# 'USAK0216' (seward, ak)
# 'USNM0292' (santa fe, nm)
# 'USVA0797' (va beach, va)
# 'USGA0506' (savannah, ga)
# 'USRI0050' (providence, ri)

weather_string = ''
units = 'f'
['USRI0050', 'USNM0292', 'USGA0506', 'USAK0216', 'USVA0797'].each {|city|
  weather_string = weather_string + get_weather_for_city(city,'f') + "\n"
}

# use the ruby mail api to create a message and send it to me

o=Hash.new
o["from"]    = ""                        # populate this with my email address
o["to"]      = ""                        # use the same email address here
o["server"]  = ""                        # put my smtp server name here
o["subject"] = "Today's Weather in Places I'd Like to Live"
mail=SendMail.new(o)
mail.body=weather_string
mail.send
