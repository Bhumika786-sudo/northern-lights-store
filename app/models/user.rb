class User < ApplicationRecord
  # 🔴 This line is REQUIRED for Devise to work
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # (Optional) extra validations – Devise already does a lot,
  # so you can keep this simple.
  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: true

  # If you have a `name` column:
  # validates :name, presence: true, length: { maximum: 100 }, allow_nil: true
end
