class WorksController < ApplicationController
  def select_country

    url = URI.escape("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address='#{form_city[:name]}'")

    response = HTTParty.get(url)
    # puts response.body, response.code, response.message, response.headers.inspect

    city = JSON.parse(response.body)
    city = city['results'].first['address_components'].first['long_name']

    url = URI.escape("http://api.openweathermap.org/data/2.5/weather?APPID=#{Rails.application.secrets.api_openweathermap_key}&q='#{city}'")
    response = HTTParty.get(url)
    @city = JSON.parse(response.body)

    # @city = Rails.application.secrets.api_openweathermap_key

    respond_to do |format|
      format.js
    end

    # respond_to do |format|
    # format.js { render js: "response_='#{country}'" }
    # end
    # render js: "response_='#{country}'"
    # return
  end

  private
  def form_city
    params.require(:form_city).permit(:name)
  end

end
