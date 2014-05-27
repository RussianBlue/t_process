class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :years, :limit => 4
      t.string :title
      t.string :p_code, :limit => 6
      t.boolean :finish, :default => 0
      t.datetime :finished_at
      t.string :width, :limit => 4
      t.string :height, :limit => 4

      t.timestamps
    end
  end
end
