class ChangeDatatypeUserIdOfArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
