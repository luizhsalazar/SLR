class AddProtocolIdToReference < ActiveRecord::Migration
  def change
    add_column :references, :protocol_id, :string
    add_index :references, :protocol_id
  end
end
