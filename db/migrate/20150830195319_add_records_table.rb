class AddRecordsTable < ActiveRecord::Migration
  def change
  	create_table :records do |t|
      t.integer :record_id , null: false
      t.string :type
      t.integer :value
      t.string :difficulty
      t.timestamp :created_at


    end

    add_index :records, :record_id
    add_index :records, :type
    add_index :records, :difficulty
  end
end
