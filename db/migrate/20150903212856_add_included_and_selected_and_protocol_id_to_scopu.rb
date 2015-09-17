class AddIncludedAndSelectedAndProtocolIdToScopu < ActiveRecord::Migration
  def change
    add_column :scopus, :included, :boolean
    add_column :scopus, :selected, :boolean
    add_column :scopus, :protocol_id_integer, :string
  end
end
