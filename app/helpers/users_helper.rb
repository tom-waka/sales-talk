module UsersHelper
  def total_likes(articles)
    articles.sum("likes_count")
  end
end
