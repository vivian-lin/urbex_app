class AddRelationToImage < ActiveRecord::Migration
  def change
    add_reference :images, :adventure, index: true, foreign_key: true
    change_table :images do |t|
      t.attachment :image
    end
  end
end
