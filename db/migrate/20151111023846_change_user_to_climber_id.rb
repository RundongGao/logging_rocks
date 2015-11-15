class ChangeUserToClimberId < ActiveRecord::Migration
  def change
  	rename_column :trainings, :user_id, :climber_id
  end
end
