class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string :key, :null => false
      t.string :value, :null => false

    end
    add_index :counters, :key
  end
end
