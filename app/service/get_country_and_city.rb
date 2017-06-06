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

        answer['results'].first['address_components'].each do |i|
          if i['types'].first == 'country'
            result[:country] = i['long_name'].to_s # country
            result[:country_key] = i['short_name'].to_s # country_key
          end
        end

      rescue Exception => e

      else
        return result
      end
    end
    false
  end

  private

  def answer
    url = URI.escape("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address='#{@country_key}, #{ @city }'")
    response = HTTParty.get(url)
    # puts response.body, response.code, response.message, response.headers.inspect

    JSON.parse(response.body)
  end

end