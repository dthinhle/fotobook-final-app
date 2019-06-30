class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :desc
      t.string :img

      t.references :imageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
