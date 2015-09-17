class AddFieldsToIeee < ActiveRecord::Migration
  def change
    add_column :ieees, :pubtype, :string
    add_column :ieees, :pubtitle, :string
    add_column :ieees, :link, :string
    add_column :ieees, :publisher, :string
  end
end
