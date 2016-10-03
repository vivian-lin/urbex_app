class Adventure < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :category_id, presence: true

  resourcify

  #adding paperclip info about image size and type
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  #adding geocoding for google maps
  geocoded_by :address
  after_validation :geocode

end
