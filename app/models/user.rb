class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  before_save { self.email = email.downcase }
  mount_uploader :picture, PictureUploader
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 },allow_nil: true
  validate :picture_size

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "画像は5MB以下のものを使用してください。")
      end
    end
end
