class CreateTableForAssociationUserAndWork < ActiveRecord::Migration[5.1]
  def change
    create_table :users_works, id: false do |t|
      t.integer :user_id, index: true
      t.integer :work_id, index: true
      t.timestamps
    end
  end
end
