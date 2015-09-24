class AddYearToAcm < ActiveRecord::Migration
  def change
    add_column :acms, :year, :integer
  end
end
