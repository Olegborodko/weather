require "spec_helper"
require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe User do

  it "has_and_belongs_to_many :works" do
    assc = described_class.reflect_on_association(:works)
    expect(assc.macro).to eq :has_and_belongs_to_many
  end

  it "create user have rid" do
    user = create(:user)
    expect(user.rid).not_to be_empty
  end

end