class CreateCalenders < ActiveRecord::Migration
  def change
    create_table :calenders do |t|
      t.string :title
      t.string :type
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
