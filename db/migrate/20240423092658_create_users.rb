class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.integer :pincode
      t.string :gender

      t.timestamps
    end
  end
end
