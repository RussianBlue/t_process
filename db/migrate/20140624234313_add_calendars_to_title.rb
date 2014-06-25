class AddCalendarsToTitle < ActiveRecord::Migration
  def change
  	add_column :calendars, :title, :string
  end
end
