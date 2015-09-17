class CreateGoogleScholars < ActiveRecord::Migration
  def change
    create_table :google_scholars do |t|
      t.text :abstract
      t.string :author
      t.string :link
      t.string :publisher
      t.string :pubtitle
      t.string :pubtype
      t.string :title
      t.integer :protocol_id
      t.boolean :included
      t.boolean :selected

      t.timestamps null: false
    end
  end
end
