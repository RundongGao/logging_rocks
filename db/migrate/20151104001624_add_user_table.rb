class AddUserTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  	  t.string :first_name
  	  t.string :last_name
      t.string :email, unique: true
      t.timestamp :created_at
  	end
  	add_index :users, [:first_name, :last_name], unique: true
  end
end
