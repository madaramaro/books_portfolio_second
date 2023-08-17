class Book < ApplicationRecord
  belongs_to :user
  has_many :favorite_list_items, dependent: :destroy
  has_many :favorite_lists, through: :favorite_list_items
  validates :title, uniqueness: { scope: [:user_id, :author], message: "既に登録済の書籍です" }
end
