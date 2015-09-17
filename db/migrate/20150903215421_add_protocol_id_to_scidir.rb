class AddProtocolIdToScidir < ActiveRecord::Migration
  def change
    add_column :scidirs, :protocol_id, :integer
  end
end
