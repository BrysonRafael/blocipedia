class AddSubIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sub_id, :string
    add_column :users, :is_premium, :boolean
  end
end
