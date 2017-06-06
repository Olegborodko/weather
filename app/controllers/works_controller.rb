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

    weather = Work.find_by location_id: location_id

    if weather
      if weather.updated_at.day != Time.now.day || weather.updated_at.month != Time.now.month

        # the weather is not up to date
        json_openweathermap = ApiOpenweathermap.new(city, country, 5).call
        json_wunderground = ApiWunderground.new(city, country, 4).call

        weather.update_attributes(json_openweathermap: json_openweathermap,
                                  json_wunderground: json_wunderground)

      end
    else
      # no weather in the database
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

    @error = ''
    @weather_show = weather_show

    respond_to do |format|
      format.js
    end

  end

  def destroy
    user = current_user
    el = params[:id].to_i

    if user
      if user.works.exists?(el)
        user.works.delete(el)
      end
    end

    @weather_show = weather_show

    respond_to do |format|
      format.js { render template: "works/create" }
    end
  end

  def show

  end

  private
  def form_region
    params.require(:form_region).permit(:city, :country_key)
  end

end
