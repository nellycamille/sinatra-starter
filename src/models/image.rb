require File.dirname(__FILE__) + "/../uploader/images_uploader"

class Image < ActiveRecord::Base
  mount_uploader :image, ImagesUploader
end
