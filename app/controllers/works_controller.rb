class WorksController < ApplicationController

  def create

    if form_region[:city].blank?
      @weather_show = weather_show
      @error = 'please enter city'
      return
    end

    country = get_country(form_region[:country_key])

    location = GetCountryAndCity.new(country, form_region[:city]).call
    if !location
      @weather_show = weather_show
      @error = 'can\'t find location'
      return
    end

    country_key = location[:country_key]
    city = location[:city]
    country = location[:country]

    # find city and country in db location and get id location (if need then create)
    location_id = get_location_id(country, country_key, city)
    user = current_user

    # погода есть в базе и она актуальная, тут проверка на актуальность
    # добавляем юзеру но не записываем и не обновляем
    weather = Work.find_by location_id: location_id

    if weather
      unless weather.updated_at.day == Time.now.day && weather.updated_at.month == Time.now.month

        # погода не актуальная
        json_openweathermap = ApiOpenweathermap.new(city, country, 5).call
        json_wunderground = ApiWunderground.new(city, country, 4).call

        weather.update_attributes(json_openweathermap: json_openweathermap,
                                  json_wunderground: json_wunderground)
      end
    else
      #погоды нет в базе
      json_openweathermap = ApiOpenweathermap.new(city, country, 5).call
      json_wunderground = ApiWunderground.new(city, country, 4).call

      weather = Work.new(location_id: location_id,
                         json_openweathermap: json_openweathermap,
                         json_wunderground: json_wunderground)
      weather.save
    end

    unless user.works.include?(weather)
      user.works << weather
    end

    @weather_show = weather_show

    respond_to do |format|
      format.js
    end

  end

  private
  def form_region
    params.require(:form_region).permit(:city, :country_key)
  end

end
