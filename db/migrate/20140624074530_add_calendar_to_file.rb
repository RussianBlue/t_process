class AddCalendarToFile < ActiveRecord::Migration
  def self.up
    add_attachment :calendars, :c_data
  end

  def self.down
    remove_attachment :calendars, :c_data
  end
end
