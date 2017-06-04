class ApiOpenweathermap

  def initialize(city, country, days)
    @key = Rails.application.secrets.api_openweathermap_key
    @city = city
    @country = country
    @days = days
  end

  def call
    get_answer = answer
    if get_answer

      begin
        result = weater_days(get_answer)
      rescue Exception => e
        { error: true }
      else
        result
      end

    else
      false
    end
  end

  private

  def weater_days(get_answer)
    result = Hash.new {|h,k| h[k] = {} }

    @days.times do |i|
      result[i][:date] = "#{(Time.now + i.day).strftime("%Y-%m-%d")}"
      result[i][:city] = @city
      result[i][:country] = @country
      result[i][:temp_min] = get_answer['list'][i]['main']['temp_min'].round
      result[i][:temp_max] = get_answer['list'][i]['main']['temp_max'].round
      result[i][:sky] = get_answer['list'][i]['weather'].first['main']
    end

    result
  end

  def answer
    url = URI.escape("http://api.openweathermap.org/data/2.5/forecast?APPID=#{@key}&units=metric&q='#{@country},#{@city}'")
    response = HTTParty.get(url)
    JSON.parse(response.body)
  end

end