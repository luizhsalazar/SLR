class AddDatabaseToReference < ActiveRecord::Migration
  def change
    add_column :references, :database, :string
  end
end
