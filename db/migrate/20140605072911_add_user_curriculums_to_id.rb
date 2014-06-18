class AddUserCurriculumsToId < ActiveRecord::Migration
  def change
  	create_table :user_curriculums do |t|
    	t.integer "user_id"
    	t.integer "curriculum_id"
  	end
  end
end
