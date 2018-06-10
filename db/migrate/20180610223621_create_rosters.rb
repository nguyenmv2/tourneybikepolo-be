class CreateRosters < ActiveRecord::Migration[5.2]
  def change
    create_table :rosters do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
