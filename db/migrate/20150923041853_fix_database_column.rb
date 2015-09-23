class FixDatabaseColumn < ActiveRecord::Migration
  def change
    rename_column :includeds, :database, :name_database
  end
end
