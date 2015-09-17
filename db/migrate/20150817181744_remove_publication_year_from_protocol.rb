class RemovePublicationYearFromProtocol < ActiveRecord::Migration
  def change
    remove_column :protocols, :publication_year, :integer
  end
end
