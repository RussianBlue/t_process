class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :m_type
      t.string :to
      t.string :from
      t.string :content

      t.timestamps
    end
  end
end
