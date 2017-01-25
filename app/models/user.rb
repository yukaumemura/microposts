class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :area, presence: true, length: { maximum: 50 } 
  validates :profile, presence: true, length: { maximum: 200 } 
  has_many :microposts
  has_secure_password
  
  #フォロー
   has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
                                     
  has_many :following_users, through: :following_relationships, source: :followed
  
   has_many :clips, dependent: :destroy #この行を追記することで関連付くイベントが削除されるとclipも削除されます。
   has_many :events, through: :clips
  
   # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  # 10.1 タイムラインを取得するメソッドの追加
   def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end