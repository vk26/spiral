class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :apartment, index: true

      t.timestamps null: false
    end
    add_foreign_key :assets, :apartments
  end
end
