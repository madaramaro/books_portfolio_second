class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :profile, length: { maximum:200 }

  # ActiveStorageの関連付け
  has_one_attached :avatar

  # Books association
  has_many :books

  has_many :favorite_lists
end
