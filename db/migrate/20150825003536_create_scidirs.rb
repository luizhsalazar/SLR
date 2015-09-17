class CreateScidirs < ActiveRecord::Migration
  def change
    create_table :scidirs do |t|
      t.text :abstract
      t.string :author
      t.string :generic_string
      t.string :link
      t.string :publisher
      t.string :pubtitle
      t.string :pubtype
      t.string :title

      t.timestamps null: false
    end
  end
end
