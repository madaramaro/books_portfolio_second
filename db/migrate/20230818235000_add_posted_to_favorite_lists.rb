class AddPostedToFavoriteLists < ActiveRecord::Migration[7.0]
  def change
    add_column :favorite_lists, :posted, :boolean,default: false
  end
end
