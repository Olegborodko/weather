class WorksController < ApplicationController
  def create

    return @error = 'please enter city' if form_region[:city].blank?
    country = get_country(form_region[:country_key])

    location = GetCountryAndCity.new(country, form_region[:city]).call
    return @error = 'can\'t find location' if !location

    country_key = location[:country_key]
    city = location[:city]
    country = location[:country]

    # find city and country in db location and get id location (if need then create)
    location_id = get_location_id(country, country_key, city)

    # find weather for today for this country and city without errors

    j = Work.find_by location_id: location_id
    if j
      if j.updated_at.day == Time.now.day && j.updated_at.month == Time.now.month &&
         eval(j.json_openweathermap).size != 1 && eval(j.json_wunderground).size != 1
        @json_1 = j.json_openweathermap
        @json_2 = j.json_wunderground
        return
      end
    end


    # if can't find then create new weather

    user = current_user
    json_openweathermap = ApiOpenweathermap.new(city, country_key, 5).call
    json_wunderground = ApiWunderground.new(city, country_key, 4).call

    result = Work.find_by user_id: user.id, location_id: location_id
    if result
      result.json_openweathermap = json_openweathermap
      result.json_wunderground = json_wunderground
      result.save
      return
    end

    if json_openweathermap || json_wunderground
      j = Work.create(user_id: user.id,
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
