class Product < ApplicationRecord
  # Active Storage for product image
  has_one_attached :image

  # --- IMAGE HANDLING METHOD ---
  # Resize image to fit your product cards
  def image_variant(width:, height:)
    image.variant(resize_to_fill: [width, height])
  end

  # --- PRICE FIX ---
  # Your DB column is current_price
  # Your views use product.price
  def price
    current_price
  end

  # Optional: if your site uses products being on sale, etc.
  # def on_sale?
  #   on_sale
  # end
end
