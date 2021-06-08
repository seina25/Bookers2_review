class ChangeRelationshipsFollowerNotNill < ActiveRecord::Migration[5.2]
  def change
    rename_table :reletionships, :relationships

  end
end
