class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fit: [Settings.upload.width, Settings.upload.height]

  version :thumb do
    process resize_to_fill: [Settings.upload.thumb, Settings.upload.thumb2]
  end

  version :show do
    process resize_to_fill: [Settings.upload.width, Settings.upload.height]
  end

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
