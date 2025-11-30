class Province < ApplicationRecord
  has_many :orders

  validates :name, presence: true
  validates :code, presence: true, length: { is: 2 } # e.g. "MB", "ON"

  validates :gst_rate,
            :pst_rate,
            :hst_rate,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true
end
