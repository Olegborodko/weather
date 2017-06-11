class CategoryAddToApis < ActiveRecord::Migration[5.1]
  def change
    add_column :apis, :category, :integer, unique: true, null: false
  end
end
