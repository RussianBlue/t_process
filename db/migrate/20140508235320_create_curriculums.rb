class CreateCurriculums < ActiveRecord::Migration
  def change
    create_table :curriculums do |t|
      t.integer :project_id
      t.integer :total, :default => 0
      t.string :title
      t.string :c_code
      t.string :location, :default => 'http://14.63.221.185/trigitcontents/'
      t.string :start, :default => 'index.html'
      t.string :progress_type_ids
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
