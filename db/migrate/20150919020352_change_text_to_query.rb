class ChangeTextToQuery < ActiveRecord::Migration
  def change
     change_column :protocols, :query, :text
  end
end
