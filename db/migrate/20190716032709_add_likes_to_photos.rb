class AddLikesToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :likes, :integer, array: true, default: []
  end
end
