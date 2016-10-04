class DropUserAdventuresTable < ActiveRecord::Migration
  def up
    drop_table :user_adventures
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
