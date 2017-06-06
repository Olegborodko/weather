module ApplicationHelper

  def weather_show
    user = current_user

    if user
      weathers = user.works
      if weathers.size>0
        results = Hash.new {|h,k| h[k] = {} }

        i = 0
        weathers.each do |ob|
          results[i][:json_openweathermap] = eval(ob.json_openweathermap)
          results[i][:json_wunderground] = eval(ob.json_wunderground)
          results[i][:id] = ob.id
          i += 1
        end
      end
      return results
    end
    false
  end
end
