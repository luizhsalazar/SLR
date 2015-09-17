class AddFromAndToToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :from, :integer
    add_column :protocols, :to, :integer
  end
end
