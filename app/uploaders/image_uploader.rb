class ImageUploader < CarrierWave::Uploader::Base
  # include Sprockets::Rails::Helper
  # include Sprockets::Helpers::IsolatedHelper

  include Cloudinary::CarrierWave
  
  process :tags => ["photo_album_sample"]
  process :convert => "png"

  version :thumbnail do
    eager
    resize_to_fit(150, 150)
    cloudinary_transformation :quality => 80          
  end  

  # For more options, see
  # http://cloudinary.com/documentation/rails_integration#carrierwave

end
