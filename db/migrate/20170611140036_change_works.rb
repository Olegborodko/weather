class ChangeWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :api_id, :integer, unique: true, null: false
    remove_column :works, :json_openweathermap
    remove_column :works, :json_wunderground
    remove_column :works, :time_openweathermap
    remove_column :works, :time_wunderground
  end
end
