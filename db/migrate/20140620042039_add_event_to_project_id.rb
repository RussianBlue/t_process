class AddEventToProjectId < ActiveRecord::Migration
  def change
  	add_column :events, :project_id, :integer
  	add_column :event_series, :project_id, :integer
  end
end
