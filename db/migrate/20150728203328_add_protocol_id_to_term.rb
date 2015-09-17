class AddProtocolIdToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :protocol_id, :integer
    add_index :terms, :protocol_id
  end
end
