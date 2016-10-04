class UserAdventure < ActiveRecord::Migration
  def change
    create_table :user_adventures, :id => false do |t|
      t.integer :user_id
      t.integer :adventure_id
    end
  end
end
