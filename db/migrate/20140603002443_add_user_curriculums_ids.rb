class AddUserCurriculumsIds < ActiveRecord::Migration
  def change
  	add_column :users, :curriculum_ids, :string
  end
end
