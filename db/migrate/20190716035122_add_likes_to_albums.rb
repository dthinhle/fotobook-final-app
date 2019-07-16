class AddLikesToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :likes, :integer, array: true, default: []
  end
end
