class WorksController < ApplicationController
  def create

    # user = current_user
    # city = current_city
    #
    # if city
    #   json_openweathermap = ApiOpenweathermap.new(city[:city], city[:country_key], 5).call
    #   json_wunderground = ApiWunderground.new(city[:city], city[:country_key], 4).call
    #
    #   if json_openweathermap || json_wunderground
    #     j = JsonRequest.create(user_id: user.id, city_id: city.id, json_openweathermap: , json_wunderground: )
    #   end
    # end


    # j = JsonRequest.create(user: user, city: city, json_openweathermap: , json_wunderground: )


    @city = GetCountryAndCity.new(form_city[:name]).call



    # if country_and_city
    #   weather = ApiOpenweathermap.new(country_and_city[:city], country_and_city[:country_key], 5).call
    #   # weather = ApiWunderground.new(country_and_city[:city], country_and_city[:country_key], 4).call
    #   if weather
    #     @city = weather
    #   end
    # end


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
  def form_city
    params.require(:form_region).permit(:name, :country)
  end

end
