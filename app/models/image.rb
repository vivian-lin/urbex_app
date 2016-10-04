class Image < ActiveRecord::Base

  belongs_to :adventure

  has_attached_file :image, styles: {large: "900x900>", medium: "300x300>", thumbnail: "150x100#"}

  do_not_validate_attachment_file_type :image
end
