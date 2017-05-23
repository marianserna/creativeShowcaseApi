class VideoSerializer < ActiveModel::Serializer
  attributes :id, :vimeo_id, :video_type, :image_url, :title, :hearts_count

  def image_url
    if Rails.env.development?
      host = 'http://localhost:3000'
      # no access to Video so, use object
      host + object.image.url(:medium)
    else
      object.image.url(:medium)
    end
  end
end
