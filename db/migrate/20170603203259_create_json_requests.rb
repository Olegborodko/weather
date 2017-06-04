class CreateJsonRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :json_requests do |t|
      t.integer :user_id
      t.integer :city_id
      t.text :json_openweathermap
      t.text :json_wunderground
      t.timestamps
    end
  end
end
