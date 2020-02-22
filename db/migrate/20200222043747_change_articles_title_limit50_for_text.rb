class ChangeArticlesTitleLimit50ForText < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :title, :text, limit: 50
  end
  def down
    change_column :articles, :title, :text
  end
end
