class AddIncludedAndSelectedToAcm < ActiveRecord::Migration
  def change
    add_column :acms, :included, :boolean
    add_column :acms, :selected, :boolean
  end
end
