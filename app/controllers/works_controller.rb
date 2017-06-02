class WorksController < ApplicationController
  def select_country

    country_and_city = GetCountryAndCity.new(form_city[:name]).call

    if country_and_city
      weather = ApiOpenweathermap.new(country_and_city[:city], country_and_city[:country_key], 5).call
      # weather = ApiWunderground.new(country_and_city[:city], country_and_city[:country_key], 4).call
      if weather
        @city = weather
      end
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
  def form_city
    params.require(:form_region).permit(:name, :country)
  end

end
