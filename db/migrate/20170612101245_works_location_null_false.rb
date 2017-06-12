class WorksLocationNullFalse < ActiveRecord::Migration[5.1]
  def change
    change_column :works, :location_id, :integer, null: false
  end
end
