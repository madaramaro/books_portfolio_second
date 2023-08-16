class Book < ApplicationRecord
  has_many :favorite_list_items, dependent: :destroy
  has_many :favorite_lists, through: :favorite_list_items
  validates :title, uniqueness: { scope: :author, message: "with this author already exists" }
end
