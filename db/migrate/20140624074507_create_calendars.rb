class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.integer :project_id

      t.timestamps
    end
  end
end
