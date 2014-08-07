class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string :key, :null => false
      t.references :value, :null => false

    end
    add_index :counters, :key
  end
end
