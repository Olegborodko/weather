class ChangeLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :country, :string, unique: true, null: false
    add_column :locations, :country_key, :string, unique: true, null: false
    rename_column :locations, :title, :city
  end
end
