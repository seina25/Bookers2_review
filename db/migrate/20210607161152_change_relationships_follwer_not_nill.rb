class ChangeRelationshipsFollwerNotNill < ActiveRecord::Migration[5.2]
  def change
    change_column_null :relationships, :follower_id, :bigint, false
    change_column_null :relationships, :followed_id, :bigint, false
  end
end
