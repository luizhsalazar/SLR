class AddYearToScopus < ActiveRecord::Migration
  def change
    add_column :scopus, :year, :integer
  end
end
