class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # cookies.delete :weather_api_setcs

  private

  def current_user
    if !cookies[:weather_api_setcs]
      user = User.create
      cookies.signed[:weather_api_setcs] = user.rid
      user
    else
      user = User.find_by rid: cookies.signed[:weather_api_setcs]

      if user
        user
      else
        user = User.new
        user.rid = cookies.signed[:weather_api_setcs]
        user.save
        user
      end
    end
  end

  def get_location_id(country, country_key, city)
    location = Location.find_by country_key: country_key, city: city
    if location
      location.id
    else
      result = Location.create(city: city, country: country, country_key: country_key)
      result.id
    end
  end

  def get_country(country_key)
    if country_key != 'EMPTY'
      IsoCountryCodes.find(country_key).name
    else
      nil
    end
  end

end
