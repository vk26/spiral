class AddFieldsToApartments < ActiveRecord::Migration
  def change
    add_reference :apartments, :city, index: true
    add_foreign_key :apartments, :cities
    add_reference :apartments, :area, index: true
    add_foreign_key :apartments, :areas
    add_column :apartments, :street, :string
    add_column :apartments, :house, :string
    add_column :apartments, :repair, :string
    add_column :apartments, :furniture, :boolean
    add_column :apartments, :date_rent, :date
    add_column :apartments, :source, :string
    add_column :apartments, :foreign_id, :integer
  end
end
