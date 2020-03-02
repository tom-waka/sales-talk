class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :title, length: {maximum: 50}
  validates :user_id, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
