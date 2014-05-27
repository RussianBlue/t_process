class AddUserToInfo < ActiveRecord::Migration
  def change
		add_column :users, :company, :string, :limit => 50
		add_column :users, :role_type, :string
		add_column :users, :celp_no, :string, :limit => 11
		add_column :users, :approval, :string, :default => 'N'
		add_column :users, :authorize, :string, :default => 'guest'
  end
end
