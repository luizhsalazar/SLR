class AddProtocolIdToIeee < ActiveRecord::Migration
  def change
    add_column :ieees, :protocol_id, :integer
  end
end
