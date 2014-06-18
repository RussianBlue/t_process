class RemoveUserProjectTable < ActiveRecord::Migration
  def change
  	drop_table :user_projects
  end
end
