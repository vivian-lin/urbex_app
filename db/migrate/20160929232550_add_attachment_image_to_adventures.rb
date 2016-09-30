class AddAttachmentImageToAdventures < ActiveRecord::Migration
  def self.up
    change_table :adventures do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :adventures, :image
  end
end
