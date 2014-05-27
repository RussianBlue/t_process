class AddBoardToFile < ActiveRecord::Migration
  def self.up
    add_attachment :boards, :data
  end

  def self.down
    remove_attachment :boards, :data
  end
end
