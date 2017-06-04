class GetCountryAndCity

  def initialize(country_key, city)
    @city = city
    @country_key = country_key
  end

  def call
    result = {}
    if answer['status']=='OK'
      begin
        result[:city] = answer['results'].first['address_components'].first['long_name'].to_s # city
        result[:country] = answer['results'].first['address_components'].last['long_name'].to_s # country
        result[:country_key] = answer['results'].first['address_components'].last['short_name'].to_s # country_key
      rescue Exception => e
        false
      else
        result
      end
    else
      false
    end
  end

  private

  def answer
    url = URI.escape("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address='#{@country_key} #{ @city }'")
    response = HTTParty.get(url)
    # puts response.body, response.code, response.message, response.headers.inspect

    JSON.parse(response.body)
  end

end