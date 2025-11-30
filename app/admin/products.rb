ActiveAdmin.register Product do
  # Allow these fields to be mass-assigned in admin
  permit_params :name,
                :description,
                :current_price,
                :stock_quantity,
                :sku,
                :brand,
                :category_id,
                :on_sale,
                :image

  # Index page with tiny thumbnail
  index do
    selectable_column
    id_column
    column :name
    column :category
    column :current_price
    column :stock_quantity
    column :on_sale
    column :image do |product|
      if product.image.attached?
        image_tag product.image.variant(resize_to_limit: [ 50, 50 ])
      end
    end
    actions
  end

  # Show page with bigger image
  show do
    attributes_table do
      row :name
      row :category
      row :description
      row :current_price
      row :stock_quantity
      row :sku
      row :brand
      row :on_sale
      row :image do |product|
        if product.image.attached?
          image_tag product.image.variant(resize_to_limit: [ 300, 300 ])
        end
      end
    end
  end

  # Form – upload/change image
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :current_price
      f.input :stock_quantity
      f.input :sku
      f.input :brand
      f.input :category
      f.input :on_sale

      f.input :image,
              as: :file,
              hint: (
                if f.object.image.attached?
                  image_tag f.object.image.variant(resize_to_limit: [ 100, 100 ])
                else
                  content_tag(:span, "No image uploaded yet")
                end
              )
    end
    f.actions
  end
end
