class AddScopusToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :scopus, :boolean
  end
end
