class AddSinonimoAndTraducaoToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :sinonimo, :string
    add_column :terms, :traducao, :string
  end
end
