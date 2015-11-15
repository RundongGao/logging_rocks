class AddClimbersInfo < ActiveRecord::Migration
  def change
  	add_column :climbers, :public, :boolean, default: false
  	add_column :climbers, :first_name, :string
  	add_column :climbers, :last_name, :string
  end
end
