class CreateFirewalls < ActiveRecord::Migration
  def change
    create_table :firewalls do |t|
      t.string :remote_ip
      t.boolean :ip_access

      t.timestamps
    end
  end
end
