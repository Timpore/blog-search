class Post < ApplicationRecord
  SIMILARITY_THRESHOLD = 0.2

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :tags
  belongs_to :category, class_name: 'Tag'

  scope :title_search, ->(query) do
    return if query.blank?

    where("similarity(posts.title, :query) > :threshold", { query: query, threshold: SIMILARITY_THRESHOLD })
  end

  scope :content_search, ->(query) do
    where("similarity(posts.content, :query) > :threshold", { query: query, threshold: SIMILARITY_THRESHOLD })
  end

  scope :search, ->(query) do
    title_search(query).or(Post.content_search(query))
  end

  scope :for_domain, ->(domain) { where(domain: domain) }

  def self.basic_search(query)
    Post.where('title LIKE ?', "%#{query}%")
  end
end
