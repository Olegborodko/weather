class UserRid < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :email, :rid
  end
end
