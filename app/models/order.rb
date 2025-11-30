class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  # Customer info
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # Totals (adjust names if your columns are slightly different)
  validates :subtotal,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :gst, :pst, :hst,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true

  validates :total,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
end
