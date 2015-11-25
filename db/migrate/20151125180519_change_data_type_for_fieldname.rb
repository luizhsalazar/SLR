class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def change
    change_column :acms, :year, :text
  end
end
