class FavoriteList < ApplicationRecord
  has_many :favorite_list_items
  has_many :books, through: :favorite_list_items
end
class FavoriteList < ApplicationRecord
end
