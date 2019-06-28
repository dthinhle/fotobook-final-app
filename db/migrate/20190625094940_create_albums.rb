class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :desc
      t.references :user

      t.timestamps
    end
  end
end
