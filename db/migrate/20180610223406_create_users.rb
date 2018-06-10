class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :nickname
      t.string :dob
      t.string :phone
      t.string :dob
      t.string :gender
      t.string :email
      t.text :bio
      t.string :avatar

      t.timestamps
    end
  end
end
