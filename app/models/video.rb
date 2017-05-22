class Video < ApplicationRecord

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

  validates :vimeo_id, :video_type, :image, :title, :hearts_count, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
