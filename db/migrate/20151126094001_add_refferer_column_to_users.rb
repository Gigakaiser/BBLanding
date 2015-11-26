class AddReffererColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :referrerid, :string
  end
end
