require "csv"

puts "Seeding categories..."

base_categories = [
  "Jackets",
  "Tents",
  "Sleeping Gear",
  "Footwear",
  "Accessories",
  "Navigation",
  "Gear"
]

categories = {}

base_categories.each do |name|
  categories[name] = Category.find_or_create_by!(name: name)
end

puts "Seeding products from CSV (db/data/products.csv) if present..."

csv_path = Rails.root.join("db", "data", "products.csv")

if File.exist?(csv_path)
  CSV.foreach(csv_path, headers: true) do |row|
    category_name = row["category_name"] || "Gear"
    category = categories[category_name] || Category.find_or_create_by!(name: category_name)

    Product.find_or_create_by!(sku: row["sku"]) do |p|
      p.name           = row["name"]
      p.description    = row["description"]
      p.current_price  = row["price"].to_f
      p.stock_quantity = row["stock_quantity"].to_i
      p.brand          = row["brand"]
      p.category       = category
      p.on_sale        = row["on_sale"].to_s.downcase == "true"
    end
  end
else
  puts "  -> CSV not found, skipping CSV import."
end

puts "Current product count: #{Product.count}"

# Make sure we have at least 100 products (rubric 1.6)
if Product.count < 100
  puts "Generating extra products to reach 100..."

  sample_descriptions = [
    "Perfect for weekend camping trips in Manitoba.",
    "Designed for cold and windy prairie conditions.",
    "Lightweight and durable for day hikes and backpacking.",
    "Tested for Canadian winters and rough terrain."
  ]

  next_number = Product.maximum(:id).to_i + 1

  while Product.count < 100
    category = categories.values.sample

    Product.create!(
      sku: "GEN-#{next_number}",
      name: "#{category.name.singularize} Item #{next_number}",
      description: sample_descriptions.sample,
      current_price: rand(40..500),
      stock_quantity: rand(5..50),
      brand: ["Arc'teryx", "Patagonia", "MSR", "Garmin", "The North Face"].sample,
      category: category,
      on_sale: [true, false].sample
    )

    next_number += 1
  end
end

puts "Final product count: #{Product.count}"
puts "Done seeding!"
