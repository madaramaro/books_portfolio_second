class AddDescriptionToFavoriteLists < ActiveRecord::Migration[7.0]
  def change
    add_column :favorite_lists, :description, :text
  end
end
