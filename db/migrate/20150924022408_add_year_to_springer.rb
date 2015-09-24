class AddYearToSpringer < ActiveRecord::Migration
  def change
    add_column :springers, :year, :integer
  end
end
