class Post < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true
  belongs_to :user
  validates :user, presence: true
  belongs_to :adventure
  validates :adventure, presence: true

  has_many :images, :dependent => :destroy
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
