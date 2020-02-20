class AddIndexToArticlesUserIdCreatedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :articles, [:user_id, :created_at]
  end
end
