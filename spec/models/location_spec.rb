require "spec_helper"
require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Location do

  it "is not valid without city" do
    location = Location.create(country: 'Ukraine', country_key: 'UA')
    expect(location).to be_invalid
  end

  it "is not valid without country" do
    location = Location.create(city: 'Odessa', country_key: 'UA')
    expect(location).to be_invalid
  end

  it "is not valid without country_key" do
    location = Location.create(city: 'Odessa', country: 'Ukraine')
    expect(location).to be_invalid
  end

  it "has_many :works" do
    assc = described_class.reflect_on_association(:works)
    expect(assc.macro).to eq :has_many
  end

  it "has_many :apis" do
    assc = described_class.reflect_on_association(:apis)
    expect(assc.macro).to eq :has_many
  end

end