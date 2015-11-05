class RenameRecordTableToFinishes < ActiveRecord::Migration
  def change
  	rename_table :records, :finishes
  end
end
