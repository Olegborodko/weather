module ApplicationHelper


  def weather_show
    user = current_user

    if user
      weathers = user.works
      if weathers.size>0
        results = []

        weathers.each do |ob|
          results << eval(ob.json_openweathermap)
          results << eval(ob.json_wunderground)
        end
      end
      return results
    end
    false
  end
end
