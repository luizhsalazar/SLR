class AddSelectedToIeee < ActiveRecord::Migration
  def change
    add_column :ieees, :selected, :boolean
  end
end
