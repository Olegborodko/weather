class ChangeJsonRequests < ActiveRecord::Migration[5.1]
  def change
    rename_column :json_requests, :city_id, :location_id
  end
end
