class CreateRoundTwos < ActiveRecord::Migration[8.0]
  def change
    create_table :round_twos do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
