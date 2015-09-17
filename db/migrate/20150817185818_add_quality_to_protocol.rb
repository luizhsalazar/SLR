class AddQualityToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :quality, :string
  end
end
