class ChangeWorksTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :works, :user_id
  end
end
