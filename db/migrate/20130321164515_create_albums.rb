class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |album|
      album.string :name
      album.references :user
      album.timestamps
    end
  end
end
