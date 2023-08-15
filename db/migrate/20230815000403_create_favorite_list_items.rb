class CreateFavoriteListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_list_items do |t|
      t.references :favorite_list, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
