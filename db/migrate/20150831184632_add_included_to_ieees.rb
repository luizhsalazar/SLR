class AddIncludedToIeees < ActiveRecord::Migration
  def change
    add_column :ieees, :included, :boolean
  end
end
