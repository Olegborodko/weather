require "spec_helper"
require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Api do

  it "is not valid without category" do
    api = Api.create
    expect(api).to be_invalid
  end

  it "valid with valid attributes" do
    api = Api.create(category: 1)
    expect(api).to be_valid
  end

  it "has_many :works" do
    assc = described_class.reflect_on_association(:works)
    expect(assc.macro).to eq :has_many
  end

  it "has_many :locations" do
    assc = described_class.reflect_on_association(:locations)
    expect(assc.macro).to eq :has_many
  end

end