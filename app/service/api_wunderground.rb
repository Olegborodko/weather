class ApiWunderground

  def initialize(city, country, days)
    @key = Rails.application.secrets.api_wunderground_key
    @city = city
    @country = country

    if days > 4
      @days = 4
    else
      @days = days
    end
  end


  def call
    result = Hash.new {|h,k| h[k] = {} }

    w_api = Wunderground.new("#{@key}")

    begin
      get_answer = w_api.forecast_for("#{@country}", "#{@city}")
      @days.times do |i|
        result[i][:date] = "#{(Time.now + i.day).strftime("%Y-%m-%d")}"
        result[i][:city] = @city
        result[i][:country] = @country
        result[i][:temp_min] = get_answer['forecast']['simpleforecast']['forecastday'][i]['low']['celsius']
        result[i][:temp_max] = get_answer['forecast']['simpleforecast']['forecastday'][i]['high']['celsius']
        result[i][:sky] = get_answer['forecast']['simpleforecast']['forecastday'][i]['conditions']
      end
    rescue Exception => e
      { error: true }
    else
      result
    end

  end

end