class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :registration_start_date
      t.datetime :registration_end_date
      t.text :description
      t.integer :team_cap

      t.timestamps
    end
  end
end
