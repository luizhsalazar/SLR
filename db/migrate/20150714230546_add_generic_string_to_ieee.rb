class AddGenericStringToIeee < ActiveRecord::Migration
  def change
    add_column :ieees, :generic_string, :string
  end
end
