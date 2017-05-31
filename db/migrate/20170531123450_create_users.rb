class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false, index: true
      t.timestamps
    end
  end
end
