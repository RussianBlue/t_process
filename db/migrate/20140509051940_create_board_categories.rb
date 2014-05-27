class CreateBoardCategories < ActiveRecord::Migration
  def change
    create_table :board_categories do |t|
      t.integer :category_id
      t.string :name
    end
  end
end
