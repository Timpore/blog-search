module ApplicationHelper
  def post_path(post)
    "#{post.domain}/#{post.slug}"
  end

  def authors(post)
    post.authors.map(&:full_name).to_sentence
  end
end
