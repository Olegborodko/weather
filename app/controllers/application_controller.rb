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

  # def current_location(country, city)
  #   result = GetCountryAndCity.new(country, city).call
  #   if result
  #     find_city = City.find_by title: result[:city]
  #
  #     if find_city
  #       find_city
  #     else
  #       City.create(title: result[:city])
  #     end
  #   end
  # end

  def location_exist_in_db?(country_key, city)
    Location.find_by country_key: country_key, city: city
  end

end
