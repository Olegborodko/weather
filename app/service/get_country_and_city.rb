class GetCountryAndCity

  def initialize(city)
    @city = city
  end

  def call
    result = {}
    if answer['status']=='OK'
      result[:city] = answer['results'].first['address_components'].first['long_name'].to_s # city
      result[:country] = answer['results'].first['address_components'][2]['long_name'].to_s # country
      result[:country_key] = answer['results'].first['address_components'][2]['short_name'].to_s # country_key
      result
    else
      false
    end
  end

  private

  def answer
    url = URI.escape("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address='#{ @city }'")
    response = HTTParty.get(url)
    # puts response.body, response.code, response.message, response.headers.inspect

    JSON.parse(response.body)
  end

end