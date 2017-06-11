class WeatherUpdate
  def initialize(location, user)
    @location = location
    @city = location.city
    @country = location.country
    @user = user
    @amount_api = 2
  end

  def call
    puts "#{@location.apis.size}<---------------------------------"
    if @location.apis.size == @amount_api
      @location.apis.each_with_index do |el, index|
        if el.time.day != Time.now.day || el.time.month != Time.now.month
          json = call_api(index + 1)
          if json
            if json[:error] == true
              el.update_attribute(time: Time.now)
            else
              el.update_attributes(json: json, time: Time.now)
            end
          end
        end
      end
    else
      (1..@amount_api).each do |i|
        json = call_api(i)
        if json
          @location.apis << api_db(json, i)
        end
      end
    end

    unless @user.works.exists?(@location.weathers)
      @user.works << @location.weathers
    end
  end

  def call_api(number)
    case number
      when 1
        result = ApiOpenweathermap.new(@city, @country, 5).call
      when 2
        result = ApiWunderground.new(@city, @country, 4).call
    end
    result
  end

  def api_db(json, category_id)
    api = Api.new

    unless json.key?(:error)
      api.json = json
    end

    api.category = category_id
    api.time = Time.now
    api.save
    api
  end

end