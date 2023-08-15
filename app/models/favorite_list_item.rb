class FavoriteListItem < ApplicationRecord
  belongs_to :favorite_list
  belongs_to :book

  def self.add_book_to_list(book, favorite_list)
    create(book: book,favorite_list: favorite_list)
  end
end
