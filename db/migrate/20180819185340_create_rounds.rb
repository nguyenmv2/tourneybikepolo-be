# frozen_string_literal: true

class CreateRounds < ActiveRecord::Migration[5.2]
  def up
    create_table :rounds do |t|
      t.string :name
      t.references :tournament, foreign_key: true

      t.timestamps
    end

    execute <<-SQL
      CREATE TYPE rounds_format_type AS ENUM ('round_robin', 'swiss_rounds', 'single_elimination', 'double_elimination');
    SQL
    add_column :rounds, :format_type, :rounds_format_type, null: false
    add_index :rounds, :format_type
  end

  def down
    drop_table :rounds

    execute <<-SQL
      DROP TYPE rounds_format_type;
    SQL
  end
end
