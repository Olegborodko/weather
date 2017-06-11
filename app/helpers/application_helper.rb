module ApplicationHelper

  def weather_show
    user = current_user

    if user
      weathers = user.works
      if weathers.size > 0
        results = Hash.new {|h,k| h[k] = {} }


        weathers.each_with_index do |ob, index|
          if ob.api.json
            results[index][:json] = eval(ob.api.json)
          end

          results[index][:id] = ob.location_id
          # puts "#{ob.api.class}<---"

        end
      end
      return results
    end
    false
  end
end
