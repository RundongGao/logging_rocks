class AddTrainingTable < ActiveRecord::Migration
  def change
  	create_table :trainings do |t|
      t.date  :date , null: false
      t.integer :user_id , null: false
      t.timestamp :created_at

    end

    add_index :trainings, :user_id
    add_index :trainings, :date
  end
end
