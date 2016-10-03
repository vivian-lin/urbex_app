class AddColumnToAdventures < ActiveRecord::Migration
  def change
    add_reference :adventures, :category, index: true, foreign_key: true
  end
end
