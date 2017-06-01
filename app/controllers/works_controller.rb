class WorksController < ApplicationController
  def select_country

    @city = form_city[:name]


    http://maps.googleapis.com/maps/api/geocode/json?address=&sensor=false


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
