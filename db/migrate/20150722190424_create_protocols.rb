class CreateProtocols < ActiveRecord::Migration
  def change
    create_table :protocols do |t|
      t.string :title
      t.string :author
      t.text :background
      t.string :research_question
      t.text :strategy
      t.text :criteria

      t.timestamps null: false
    end
  end
end
