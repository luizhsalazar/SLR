class AddResultsReturnedToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :results_returned, :integer
  end
end
