class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :event
      t.references :user
      t.integer :params, array: true, default: []

      t.timestamps
    end

    add_index :notifications, :event
  end
end
