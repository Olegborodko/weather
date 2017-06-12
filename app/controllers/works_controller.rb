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


    location = get_location(country, country_key, city)
    user = current_user

    weather = WeatherUpdate.new(location, user).call

    @error = ''
    @weather_show = weather_show

    respond_to do |format|
      format.js
    end

  end

  def destroy
    user = current_user
    location_id = params[:id].to_i

    if user
      user.works.where(location_id: location_id).each do |el|
        user.works.delete(el.id)
        #user.works.clear
      end
    end

    @weather_show = weather_show

    respond_to do |format|
      format.js { render template: "works/create" }
    end
  end

  def show

  end

  def new
    cookies.delete :weather_api_setcs
  end

  private
  def form_region
    params.require(:form_region).permit(:city, :country_key)
  end

end
