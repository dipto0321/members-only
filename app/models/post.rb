class Post < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :user
  has_many :comments, as: :commentable

  def post_created
    self.created_at.localtime.to_s.gsub(/.\+.{4}/, '')
  end

  def self.all_posts
    select(:id, :title, :user_id, :content).includes(:user)
  end

  def author
    user
  end
end
