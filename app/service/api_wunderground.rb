class ApiWunderground

  def initialize(city, country_key, days)
    @key = Rails.application.secrets.api_wunderground_key
    @city = city
    @country_key = country_key

    if days > 4
      @days = 4
    else
      @days = days
    end
  end


  def call
    result = Hash.new {|h,k| h[k] = {} }

    w_api = Wunderground.new("#{@key}")
    get_answer = w_api.forecast_for(@country_key, @city)

    @days.times do |i|
      result[i][:temp_min] = get_answer['forecast']['simpleforecast']['forecastday'][i]['low']['celsius']
      result[i][:temp_max] = get_answer['forecast']['simpleforecast']['forecastday'][i]['high']['celsius']
      result[i][:sky] = get_answer['forecast']['simpleforecast']['forecastday'][i]['conditions']
    end

    result

  end

end