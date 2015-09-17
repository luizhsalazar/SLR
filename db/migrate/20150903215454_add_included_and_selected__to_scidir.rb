class AddIncludedAndSelectedToScidir < ActiveRecord::Migration
  def change
    add_column :scidirs, :included, :boolean
    add_column :scidirs, :selected, :boolean
  end
end
