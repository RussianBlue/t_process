class RemoveUserProjectsProjectId < ActiveRecord::Migration
  def change
  	remove_column :user_projects :project_id
  end
end
