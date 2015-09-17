class AddProtocolIdToScopu < ActiveRecord::Migration
  def change
    add_column :scopus, :protocol_id, :integer
  end
end
