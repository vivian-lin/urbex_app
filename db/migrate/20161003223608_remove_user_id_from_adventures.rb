class RemoveUserIdFromAdventures < ActiveRecord::Migration
  def change
    remove_column :adventures, :user_id, :integer
  end
end
