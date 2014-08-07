class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references :topic, :null => false
      t.text :body, :null => false
      t.references :user, :null => false
      t.integer :state, :null => false, :default => 1
      t.string :source

      t.timestamps
    end
    add_index :replies, :user_id
    add_index :replies, :topic_id
  end
end
