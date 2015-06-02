class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.text :description
      t.string :renter
      t.string :phone1
      t.string :phone2
      t.string :type
      t.integer :price

      t.timestamps null: false
    end
  end
end
