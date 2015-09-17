class AddScienceDirectAndGoogleScholarToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :science_direct, :boolean
    add_column :protocols, :google_scholar, :boolean
  end
end
