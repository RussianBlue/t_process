class AddContentTypeToText < ActiveRecord::Migration
  def self.up     
    change_column :boards, :content, :text, :limit => 16777215, :default => nil, :null => true
  end   

  def self.down     
    change_column :boards, :content, :string, :default => nil, :null => true
  end
end
