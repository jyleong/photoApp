class Image < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  ## carrerir wave to associate image with the model we have
  ##mount_uploader method we use
end
