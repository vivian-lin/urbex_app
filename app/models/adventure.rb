class Adventure < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :category

  has_many :images, :dependent => :destroy
  has_many :posts

  validates :name, presence: true
  validates :category_id, presence: true
  resourcify

  #adding paperclip info about image size and type
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", small: "50x50#", thumb: "150x150#"}

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  #adding geocoding for google maps
  geocoded_by :address
  after_validation :geocode

end
