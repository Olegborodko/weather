class WorksController < ApplicationController

  def create

    if form_region[:city].blank?
      @weather_show = weather_show
      @error = 'please enter city'
      return
    end

    country = get_country(form_region[:country_key])

    location = GetCountryAndCity.new(country, form_region[:country_key], form_region[:city]).call
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

      if weather.time_openweathermap.day != Time.now.day || weather.time_openweathermap.month != Time.now.month
        json_openweathermap = ApiOpenweathermap.new(city, country, 5).call
        if json_openweathermap
          if json_openweathermap[:error] == true
            weather.update_attribute(time_openweathermap: Time.now)
          else
            weather.update_attributes(json_openweathermap: json_openweathermap, time_openweathermap: Time.now)
          end
        end
      end

      if weather.time_wunderground.day != Time.now.day || weather.time_wunderground.month != Time.now.month
        json_wunderground = ApiWunderground.new(city, country, 4).call
        if json_wunderground
          if json_wunderground[:error] == true
            weather.update_attribute(time_wunderground: Time.now)
          else
            weather.update_attributes(json_wunderground: json_wunderground, time_wunderground: Time.now)
          end
        end
      end

    else
      # no weather in the database
      json_openweathermap = ApiOpenweathermap.new(city, country, 5).call
      json_wunderground = ApiWunderground.new(city, country, 4).call

      if json_openweathermap == false && json_wunderground == false
        @weather_show = weather_show
        @error = 'can\'t find results'
        return
      end

      weather = Work.new

      if json_openweathermap
        weather.time_openweathermap = Time.now
        unless json_openweathermap.key?(:error)
          weather.json_openweathermap = json_openweathermap
        end
      end

      if json_wunderground
        weather.time_wunderground = Time.now
        unless json_wunderground.key?(:error)
          weather.json_wunderground = json_wunderground
        end
      end

      weather.location_id = location_id
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
