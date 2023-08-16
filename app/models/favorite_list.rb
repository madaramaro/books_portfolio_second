class FavoriteList < ApplicationRecord
  belongs_to :user  # この行を追加

  has_many :favorite_list_items
  has_many :books, through: :favorite_list_items
end

