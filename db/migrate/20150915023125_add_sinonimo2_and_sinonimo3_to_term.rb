class AddSinonimo2AndSinonimo3ToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :sinonimo2, :string
    add_column :terms, :sinonimo3, :string
  end
end
