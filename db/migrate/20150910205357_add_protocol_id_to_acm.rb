class AddProtocolIdToAcm < ActiveRecord::Migration
  def change
    add_column :acms, :protocol_id, :integer
  end
end
