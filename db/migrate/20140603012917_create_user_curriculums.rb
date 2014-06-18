class CreateUserCurriculums < ActiveRecord::Migration
  def change
    create_table :user_curriculums, id: false do |t|
      t.belongs_to :user
      t.belongs_to :curriculum
    end
  end
end
