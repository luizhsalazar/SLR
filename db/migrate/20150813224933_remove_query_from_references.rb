class RemoveQueryFromReferences < ActiveRecord::Migration
  def change
    remove_column :references, :query, :string
  end
end
