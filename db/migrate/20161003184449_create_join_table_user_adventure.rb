class CreateJoinTableUserAdventure < ActiveRecord::Migration
  def change
    create_join_table :users, :adventures do |t|
      t.index [:user_id, :adventure_id]
      t.index [:adventure_id, :user_id]
    end
  end
end
