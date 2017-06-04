class UsersController < ApplicationController
  def index

    # if current_user then show results

    user = current_user

    if user
      @json_1 = []
      @json_2 = []

      JsonRequest.where(user_id: user.id).each do |ob|
        @json_1 << eval(ob.json_openweathermap)
        @json_2 << eval(ob.json_wunderground)
      end
    end

  end
end
