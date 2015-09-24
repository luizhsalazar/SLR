class AddYearToIeee < ActiveRecord::Migration
  def change
    add_column :ieees, :year, :integer
  end
end
