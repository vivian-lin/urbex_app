class Post < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true
  belongs_to :user
  validates :user, presence: true
  belongs_to :adventure
  validates :adventure, presence: true
end
