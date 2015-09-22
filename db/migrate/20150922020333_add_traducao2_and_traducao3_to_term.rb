class AddTraducao2AndTraducao3ToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :traducao2, :string
    add_column :terms, :traducao3, :string
  end
end
