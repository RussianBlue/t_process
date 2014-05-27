class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :curriculum_id
      t.integer :lesson
      t.boolean :content_use
      t.string :p_data
      t.string :s_data

      t.timestamps
    end
  end
end
