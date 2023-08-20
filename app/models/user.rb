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

  has_many :favorite_lists, dependent: :destroy

  # follow
  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_follows, source: :followed 
  has_many :followers, through: :passive_follows, source: :follower

  def follow(other_user)
    unless self == other_user
      self.following << other_user
    end
  end

  # ユーザーのフォローを解除する
  def unfollow(other_user)
    self.following.delete(other_user)
  end

  # あるユーザーをフォローしているかどうかを確認する
  def following?(other_user)
    self.following.include?(other_user)
  end
end
