class AddLinkToIncluded < ActiveRecord::Migration
  def change
    add_column :includeds, :link, :string
  end
end
