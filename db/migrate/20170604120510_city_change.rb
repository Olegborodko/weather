class CityChange < ActiveRecord::Migration[5.1]
  def change
    rename_table :cities, :locations
  end
end
