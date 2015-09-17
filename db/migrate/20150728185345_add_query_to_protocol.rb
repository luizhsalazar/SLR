class AddQueryToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :query, :string
  end
end
