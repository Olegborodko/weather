require "spec_helper"
require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Work do

  it "valid with valid attributes" do
    location = create(:location)
    work = Work.create(location_id: location.id)
    expect(work).to be_valid
  end

  it "is not valid without location_id" do
    work = Work.create
    expect(work).to be_invalid
  end

  it "is not valid without unique location_id" do
    location = create(:location)
    work = Work.create(location_id: location.id)
    expect(work).to be_valid

    work = Work.create(location_id: location.id)
    expect(work).to be_invalid
  end

  it "belongs_to :location" do
    assc = described_class.reflect_on_association(:location)
    expect(assc.macro).to eq :belongs_to
  end

  it "has_and_belongs_to_many :users" do
    assc = described_class.reflect_on_association(:users)
    expect(assc.macro).to eq :has_and_belongs_to_many
  end


end