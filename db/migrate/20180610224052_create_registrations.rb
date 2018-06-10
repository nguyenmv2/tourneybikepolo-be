class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.references :enrollment, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
