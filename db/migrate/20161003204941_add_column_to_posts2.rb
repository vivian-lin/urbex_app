class AddColumnToPosts2 < ActiveRecord::Migration
  def change
    add_reference :posts, :adventure, index: true, foreign_key: true
  end
end
