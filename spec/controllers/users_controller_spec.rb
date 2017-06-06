require "spec_helper"
require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe UsersController do

  it "index" do
    get :index
    is_expected.to render_template(:index)

    user = controller.send(:current_user)

    expect(user).to eq User.last
    expect(user.works.size).to eq 0
    expect(assigns(:weather_show)).to eq(nil)
  end

end