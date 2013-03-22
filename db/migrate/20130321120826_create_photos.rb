class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |photo|
      photo.string :title, :caption, :image_path
      photo.references :album
      photo.timestamps
    end
  end
end
