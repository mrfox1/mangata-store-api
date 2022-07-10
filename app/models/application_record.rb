class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.build_image(id, file, content_type = 'image')
    return if file.blank?

    file_name = file.is_a?(CarrierWave::Uploader::Base) ? file.file.filename : file

    image_path = "/uploads/#{ self.name.underscore }/#{ id }"

    if Rails.env.development?
      image_path = "#{ ENV['API_HOST'] }#{ image_path }"
    end

    thumbnail_file_name = content_type == 'image' ? file_name : file_name.gsub(/\.([^.]+)$/, '.png')
    {
      url: "#{ image_path }/#{ file_name }",
      thumbnail: {
        url: "#{ image_path }/thumbnail_#{ thumbnail_file_name }"
      },
      medium: {
        url: "#{ image_path }/medium_#{ thumbnail_file_name }"
      }
    }
  end
end
