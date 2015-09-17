class CreateIeees < ActiveRecord::Migration
  def change
    create_table :ieees do |t|
      t.string :title
      t.string :author
      t.text :abstract

      t.timestamps null: false
    end
  end
end
