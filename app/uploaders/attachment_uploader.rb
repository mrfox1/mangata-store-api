class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{ model.class.to_s.underscore }/#{ model.id }"
  end

  def extension_allowlist
    %w(jpg jpeg png)
  end

  def content_type_allowlist
    /image\//
  end

  version :thumbnail do
    process resize_to_limit: [80, 80]
  end

  version :medium do
    process resize_to_limit: [200, 200]
  end
end
