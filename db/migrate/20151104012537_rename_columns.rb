class RenameColumns < ActiveRecord::Migration
  def change
    rename_column :finishes, :type, :catagory
    rename_column :finishes, :record_id, :training_id
  end
end
