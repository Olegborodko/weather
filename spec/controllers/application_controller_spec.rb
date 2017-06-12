require "spec_helper"
require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe ApplicationController do

  before do
    @location = create(:location)
  end

  it "current_user" do
    user = controller.send(:current_user)
    expect(user.class).to eq User.new.class
  end

  it "get_location create" do
    location = controller.send(:get_location, 'Ukraine', 'UA', 'Cherkassy')
    expect(location).to eq Location.last
  end

  it "get_location exists" do
    location = controller.send(:get_location, @location.country, @location.country_key, @location.city)
    result = Location.find_by city: @location.city, country_key: @location.country_key
    expect(location).to eq result
  end

  it "get_country" do
    result = controller.send(:get_country, 'UA')
    expect(result).to eq 'Ukraine'
  end

  it "get_country empty" do
    result = controller.send(:get_country, 'EMPTY')
    expect(result).to eq nil
  end

end