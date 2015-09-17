class AddUserIdToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :user_id, :integer
    add_index :protocols, :user_id
  end
end
