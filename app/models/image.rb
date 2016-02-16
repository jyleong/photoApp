class Image < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  ## carrerir wave to associate image with the model we have
  ##mount_uploader method we use
  validate :picture_size
  
  private
  
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:pictures, "should be less than 5MB")
    end
  end
end
