class Post < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true
  belongs_to :user
  validates :user, presence: true
  belongs_to :adventure
  validates :adventure, presence: true
  # adding default order so most recent posts appear at the top of the posts list
  default_scope -> { order(created_at: :desc) }
end
