class AddUserDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_description, :text
  end
end
