class Photo < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :album
  mount_uploader :image_path, Uploader

end
