class CreateApis < ActiveRecord::Migration[5.1]
  def change
    create_table :apis do |t|
      t.text :json
      t.datetime :time
      t.timestamps
    end
  end
end
