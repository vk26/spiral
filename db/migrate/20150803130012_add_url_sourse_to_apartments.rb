class AddUrlSourseToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :url_source, :string
  end
end
