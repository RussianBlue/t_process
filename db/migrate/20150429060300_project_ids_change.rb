class ProjectIdsChange < ActiveRecord::Migration
  change_table :projects do |t|
    t.rename :board_ids, :board_id
  end
end
