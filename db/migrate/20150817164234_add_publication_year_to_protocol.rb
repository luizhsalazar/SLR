class AddPublicationYearToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :publication_year, :integer
  end
end
