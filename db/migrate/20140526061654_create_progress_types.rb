class CreateProgressTypes < ActiveRecord::Migration
  def change
    create_table :progress_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
