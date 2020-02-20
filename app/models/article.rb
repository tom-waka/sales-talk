class Article < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :title, length: {maximum: 50}
  validates :user_id, presence: true
end
