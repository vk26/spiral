class ChangeApartments < ActiveRecord::Migration
  def change
    change_table :apartments do |t|
      t.rename :type, :type_apartment
    end
  end
end
