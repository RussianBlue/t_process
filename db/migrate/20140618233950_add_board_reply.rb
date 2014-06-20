class AddBoardReply < ActiveRecord::Migration
  def change
  	add_column :boards, :group_no, :integer
  	add_column :boards, :level, :integer
  	add_column :boards, :seq_no, :integer
  end
end
