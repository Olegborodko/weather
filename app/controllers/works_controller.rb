class WorksController < ApplicationController
  def create

    return @error = 'please enter city' if form_region[:city].blank?

    # if form_region[:country_key].blank?

    if form_region[:country_key] != 'EMPTY'
      country = IsoCountryCodes.find(form_region[:country_key]).name
    else
      country = ''
    end

    location = GetCountryAndCity.new(country, form_region[:city]).call
    return @error = 'can\'t find location' if !location

    country_key = location[:country_key]
    city = location[:city]
    country = location[:country]
    # else
    #   country_key = form_region[:country_key]
    #   city = form_region[:city]
    #   country = IsoCountryCodes.find(country_key).name
    # end


    # find city and country in db location and get id location

    location = Location.find_by country_key: country_key, city: city
    if location
      location_id = location.id
    else
      result = Location.create(city: city, country: country, country_key: country_key)
      location_id = result.id
    end


    # find weather for today for this country and city

    j = JsonRequest.find_by location_id: location_id
    if j
      if j.updated_at.day == Time.now.day || j.updated_at.month == Time.now.month
        @json_1 = j.json_openweathermap
        @json_2 = j.json_wunderground
        return
      end
    end


    # if can't find then create new weather

    user = current_user

    json_openweathermap = ApiOpenweathermap.new(city, country_key, 5).call
    json_wunderground = ApiWunderground.new(city, country_key, 4).call

    if json_openweathermap || json_wunderground
      j = JsonRequest.create(user_id: user.id,
                             location_id: location_id,
                             json_openweathermap: json_openweathermap,
                             json_wunderground: json_wunderground)
      @json_1 = j.json_openweathermap
      @json_2 = j.json_wunderground
    end


    #respond_to do |format|
    #  format.js
    #end

    # respond_to do |format|
    # format.js { render js: "response_='#{country}'" }
    # end
    # render js: "response_='#{country}'"
    # return
  end

  private
  def form_region
    params.require(:form_region).permit(:city, :country_key)
  end

end
