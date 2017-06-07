class TableWorkChange < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :time_openweathermap, :datetime
    add_column :works, :time_wunderground, :datetime
  end
end
