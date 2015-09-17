class CreateScopus < ActiveRecord::Migration
  def change
    create_table :scopus do |t|
      t.text :abstract
      t.string :author
      t.string :link
      t.string :publisher
      t.string :pubtitle
      t.string :pubtype
      t.string :title

      t.timestamps null: false
    end
  end
end
