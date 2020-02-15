class ChangeArticlesTitleLimit50 < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :title, :string, limit: 50
  end
  def down
    change_column :articles, :title, :string
  end
end
