FactoryGirl.define do
  factory :work do
    association :location, factory: :location
    json_openweathermap { "{0=>{:date=>\"2017-06-06\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>22, :temp_max=>25, :sky=>\"Clear\"}, 1=>{:date=>\"2017-06-07\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>22, :temp_max=>25, :sky=>\"Clear\"}, 2=>{:date=>\"2017-06-08\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>21, :temp_max=>23, :sky=>\"Clear\"}, 3=>{:date=>\"2017-06-09\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>19, :temp_max=>20, :sky=>\"Clear\"}, 4=>{:date=>\"2017-06-10\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>18, :temp_max=>18, :sky=>\"Clear\"}}" }
    json_wunderground { "{0=>{:date=>\"2017-06-06\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>22, :temp_max=>25, :sky=>\"Clear\"}, 1=>{:date=>\"2017-06-07\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>22, :temp_max=>25, :sky=>\"Clear\"}, 2=>{:date=>\"2017-06-08\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>21, :temp_max=>23, :sky=>\"Clear\"}, 3=>{:date=>\"2017-06-09\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>19, :temp_max=>20, :sky=>\"Clear\"}, 4=>{:date=>\"2017-06-10\", :city=>\"Odessa\", :country=>\"Ukraine\", :temp_min=>18, :temp_max=>18, :sky=>\"Clear\"}}" }
    time_openweathermap { Time.now }
    time_wunderground { Time.now }
  end
end