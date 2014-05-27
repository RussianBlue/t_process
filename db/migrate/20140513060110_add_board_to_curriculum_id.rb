class AddBoardToCurriculumId < ActiveRecord::Migration
  def change
  	add_column :boards, :curriculum_id, :integer
  	add_column :projects, :board_ids, :string
  end
end
