class AddDatabaseToIncluded < ActiveRecord::Migration
  def change
    add_column :includeds, :database, :string
  end
end
