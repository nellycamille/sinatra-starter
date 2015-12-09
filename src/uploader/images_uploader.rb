class ImagesUploader < CarrierWave::Uploader::Base
  storage :fog
end
