class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :name, presence: true, length: { maximum: 100 }
  validates :slug, presence: true, uniqueness: true, length: { maximum: 100 }, allow_nil: true
end
