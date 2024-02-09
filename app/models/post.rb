class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 1..250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  after_save :update_posts_counter

  def last_five_comments
    comments.order(created_at: :DESC).limit(5)
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.length)
  end
end
