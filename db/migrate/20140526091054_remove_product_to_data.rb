class RemoveProductToData < ActiveRecord::Migration
  def change
  	remove_column :products, :p_data
  	remove_column :products, :s_data
  end
end
