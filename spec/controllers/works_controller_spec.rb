require "spec_helper"
require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe WorksController do

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
    weather = create(:work, updated_at: Time.now - 1.day)
    post :create, params: {form_region: {city: 'Odessa', country_key: 'UA'}}, format: :js

    work = Work.last

    expect(Location.all.size).to eq 1
    expect(Work.all.size).to eq 1
    expect(work.updated_at.day).to eq Time.now.day
  end



  # it "create (weather update)" do
    # weather = create(:work, updated_at: Time.now - 1.day)
  # end


end