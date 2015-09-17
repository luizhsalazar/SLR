class AddDatabaseNameAndResultsToReference < ActiveRecord::Migration
  def change
    add_column :references, :database_name, :string
    add_column :references, :results, :string
  end
end
