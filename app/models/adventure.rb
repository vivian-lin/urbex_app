class Adventure < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :category_id, presence: true
end
