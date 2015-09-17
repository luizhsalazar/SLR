class AddTotalFoundToReference < ActiveRecord::Migration
  def change
    add_column :references, :total_found, :integer
  end
end
