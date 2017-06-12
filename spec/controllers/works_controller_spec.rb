require "spec_helper"
require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe WorksController do

  before do
    @api = create(:api)
    @location = create(:location)
    @weather1 = create(:work, location_id: @location.id, api_id: @api.id)

    @api2 = create(:api, category: 2)
    @weather2 = create(:work, location_id: @location.id, api_id: @api2.id)

    @user = controller.send(:current_user)

    @user.works << @weather1
    @user.works << @weather2
  end

  it "create (city blank)" do
    post :create, params: {form_region: {city: nil, country_key: 'UA'}}, format: :js
    expect(assigns(:error)).to eq('please enter city')
  end

  it "create (can't find location)" do
    post :create, params: {form_region: {city: 'qwerwefwefwef', country_key: 'EMPTY'}}, format: :js
    expect(assigns(:error)).to eq('can\'t find location')
  end

  it "create (create location)" do
    post :create, params: {form_region: {city: 'Odessa', country_key: 'UA'}}, format: :js
    location = Location.last
    expect(location.city).to eq('Odessa')
  end

  it "create (weather exists)" do
    expect(Work.all.size).to eq 2

    post :create, params: {form_region: {city: 'Odessa', country_key: 'UA'}}, format: :js

    expect(Work.all.size).to eq 2

    api = Api.first
    api2 = Api.last

    expect(api.time.day).to eq Time.now.day
    expect(api2.time.month).to eq Time.now.month
  end

  it "create (weather new)" do
    post :create, params: {form_region: {city: 'Kiev', country_key: 'UA'}}, format: :js

    expect(Work.all.size).to eq 4
    expect(Location.all.size).to eq 2
    expect(User.all.size).to eq 1
    expect(Api.all.size).to eq 4
    expect(response).to render_template(:create)
  end

  it "destroy ok" do
    delete :destroy, params: { id: @location.id }, format: :js
    expect(@user.works.size).to eq 0
    expect(response).to render_template(:create)
  end

  it "destroy not deleted" do
    delete :destroy, params: { id: 0 }, format: :js
    expect(@user.works.size).to eq 2
    expect(response).to render_template(:create)
  end

end