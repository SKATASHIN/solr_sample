class CreateRoundThrees < ActiveRecord::Migration[8.0]
  def change
    create_table :round_threes do |t|
      t.string :title
      t.text :body
      t.timestamps null: false
    end
  end
end
