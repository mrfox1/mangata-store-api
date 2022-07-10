json.(@category,
  :id,
  :title,
  :category_id,
  :created_at,
  :updated_at
)

if @category.attachment.present?
  json.image Attachment.build_image(@category.attachment.id, @category.attachment.attachment)
end
