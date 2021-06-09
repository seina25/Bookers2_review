class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 与フォロー（能動的）
  has_many :reverse_of_relationships, class_name: 'Reletionship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  # 被フォロー（受動的）
  has_many :relationships, class_name: 'Reletionship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  
  # フォローする・外す・フォローしているか確認を行うメソッドたち
  # ユーザをフォローする
  def follow(user_id)
    unless self == user_id
      self.relationships.find_or_create_by(followed_id: user_id)
    end
  end
  # ユーザのフォロー外す
  def unfollow(user_id)
    relationship = self.relationships.find_by(followed_id: user_id)
    relationship.destroy if relationship
  end
  # フォローしていたらtrueを返す
  def following?(user)
    self.following.include?(user)
  end
  
end
