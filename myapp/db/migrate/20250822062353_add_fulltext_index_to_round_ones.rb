class AddFulltextIndexToRoundOnes < ActiveRecord::Migration[8.0]
  def change
    add_index :round_ones, :created_at, name: "idx_round_ones_created_at"

    reversible do |dir|
      dir.up do
        execute <<~SQL
          ALTER TABLE round_ones
          ADD FULLTEXT INDEX ftx_round_ones_body (body)
        SQL
      end

      dir.down do
        execute <<~SQL
          ALTER TABLE round_ones
          DROP INDEX ftx_round_ones_body
        SQL
      end
    end
  end
end
