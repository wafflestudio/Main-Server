# encoding: utf-8

class FlyerUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if model.restaurant != nil
      "flyers/restaurants/#{model.restaurant.id}"
    elsif model.restaurant_suggestion != nil
      "flyers/restaurant_suggestions/#{model.restaurant_suggestion.id}"
    end
  end

  def filename
    if model.restaurant != nil
      "#{model.restaurant.phone_number}-#{secure_token}.#{file.extension}" 
    elsif model.restaurant_suggestion != nil
      "#{model.restaurant_suggestion.id}-#{secure_token}.#{file.extension}" 
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :resize_to_fit => [700, 700]

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end


  private
  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
