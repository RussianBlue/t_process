class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :project_id
      t.integer :category_id
      t.string :title, :limit => 100
      t.string :pre_title, :limit => 10
      t.integer :user_id
      t.integer :count_at, :default => 0
      t.string :content

      t.timestamps
    end
  end
end
