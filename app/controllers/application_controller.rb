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
      User.find_by rid: cookies.signed[:weather_api_setcs]
    end
  end

  def current_city
    result = GetCountryAndCity.new(form_city[:name]).call
    if result
      find_city = City.find_by title: result[:city]

      if find_city
        find_city
      else
        City.create(title: result[:city])
      end
    end
  end

end
