class Post < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :user

  def post_created
    self.created_at.localtime.to_s.gsub(/.\+.{4}/, '')
  end
end
