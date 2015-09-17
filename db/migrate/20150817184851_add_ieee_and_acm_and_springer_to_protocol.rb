class AddIeeeAndAcmAndSpringerToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :ieee, :boolean
    add_column :protocols, :acm, :boolean
    add_column :protocols, :springer, :boolean
  end
end
