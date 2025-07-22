class CreateRoundOnes < ActiveRecord::Migration[8.0]
  def change
    create_table :round_ones do |t|
      t.text :body

      t.timestamps
    end
  end
end
