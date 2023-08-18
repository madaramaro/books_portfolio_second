class FavoriteList < ApplicationRecord
  belongs_to :user  # この行を追加
  validates :name, uniqueness: { scope: :user_id, massage: 'その名前のリストは既に存在します' }
  has_many :favorite_list_items, dependent: :destroy
  has_many :books, through: :favorite_list_items
end

