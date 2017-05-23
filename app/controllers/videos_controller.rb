class VideosController < ApplicationController

  def index
    videos = Video.all
    render json: videos
  end

  def create
    data = vimeo_data
    # raise data.inspect --> raises informative error
    # create with validation: Video.new and later on if statement. Else -> Video.create
    video = Video.new({
      vimeo_id: vimeo_id,
      video_type: params[:video_type],
      image: data['thumbnail_large'],
      title: data['title']
    })

    if video.save
      render json: video
    else
      render json: video.errors.to_json, status: :bad_request
    end
  end

  def motion
    videos = Video.where(video_type: 'motion').all
    render json: videos
  end

  def vr
    videos = Video.where(video_type: 'vr').all
    render json: videos
  end

  def interactive
    videos = Video.where(video_type: 'interactive').all
    render json: videos
  end

  def heart
    video = Video.find(params[:id])
    # Not recommended way:
    # video.hearts_count += 1
    # video.save
    # Also not recommended: because of concurrency issue
    video.increment!(:hearts_count)
    render json: video
  end

  def featured
    # there are 2 types of where clauses in rails. Eg:
    # Video.where(vide_type: 'vr') -> where video type is = to vr
    # >, <, >=, <= can't use that syntax: you need to pass it as a string:
    videos = Video.where("hearts_count > 5").order(created_at: :desc).limit(5)
    # if the value were coming form the user: Video.where("hearts_count > ?", 5) or Video.where("hearts_count > ?", params[:value])
    # if you have multiple Video.where("hearts_count > ? and video_type", params[:value], 'vr'). This isn't recommended. You can do:
    # Video.where("hearts_count > :count and video_type = :type", conunt: params[:value], type: 'vr')
    render json: videos
  end

  private

  def vimeo_id
    url = params[:vimeo_url]
    # Find the id within the url using this regEx
    match = url.match(/vimeo\.com\/(\d+)/)
    # get the 1st match (which is the number only)
    match[1]
  end

  def vimeo_data
    # Use the API url to embed the video id. Convert into JSON and get the fist hash
    HTTP.get("https://vimeo.com/api/v2/video/#{vimeo_id}.json").parse(:json).first
  end

end
