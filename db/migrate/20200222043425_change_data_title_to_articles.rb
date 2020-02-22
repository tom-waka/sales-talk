class ChangeDataTitleToArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :title, :text
  end
end
