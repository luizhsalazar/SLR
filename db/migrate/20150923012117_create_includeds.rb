class CreateIncludeds < ActiveRecord::Migration
  def change
    create_table :includeds do |t|
      t.string :title
      t.string :author
      t.string :pubtitle
      t.boolean :included
      t.integer :protocol_id

      t.timestamps null: false
    end
  end
end
