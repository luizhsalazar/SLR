class AddYearToScidir < ActiveRecord::Migration
  def change
    add_column :scidirs, :year, :integer
  end
end
