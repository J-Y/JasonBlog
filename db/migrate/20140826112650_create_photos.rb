class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title, :null => false
      t.string :image_file_name, :null => false
      t.string :image_content_type, :null => false
      t.integer :image_file_size, :null => false, :default => 0
      t.references :user, :null => false

      t.timestamps
    end
    add_index :photos, :user_id
  end
end
