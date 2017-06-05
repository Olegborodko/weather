class RenameTableJson < ActiveRecord::Migration[5.1]
  def change
    rename_table :json_requests, :works
  end
end
