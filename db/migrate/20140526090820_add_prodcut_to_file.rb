class AddProdcutToFile < ActiveRecord::Migration
  def self.up
    add_attachment :products, :p_data
    add_attachment :products, :s_data
  end

  def self.down
    remove_attachment :products, :p_data
    remove_attachment :products, :s_data
  end
end
