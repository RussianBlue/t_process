class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.integer :curriculum_id
      t.integer :lesson
      t.integer :process
      t.integer :progress_type_id, :default => 0
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
