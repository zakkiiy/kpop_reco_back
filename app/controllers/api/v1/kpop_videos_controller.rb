class Api::V1::KpopVideosController < ApplicationController
  def index
    kpop_videos = KpopVideo.where(video_type: :normal).includes(:artist)
    render json: kpop_videos.as_json(include: { artist: { only: [:name] } })
  end

  def create_videos
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = ENV['YOUTUBE_API_KEY']

    artists = Artist.all
    channel_ids = artists.map(&:channel_id)
    p channel_ids

    video_lists = []

    channel_ids.each do |channel_id|
      begin
        response = service.list_searches('snippet', channel_id: channel_id, order: 'date', type: 'video', max_results: 10)

        # File.open("response_#{channel_id}.json", "w") do |file|
        #   file.write(JSON.pretty_generate(response.to_h))
        # end

        video_ids = response.items.map { |item| item.id.video_id }

        video_details_response = service.list_videos('snippet,statistics,contentDetails', id: video_ids.join(','))

        File.open("video_details_response_#{channel_id}.json", "w") do |file|
          file.write(JSON.pretty_generate(video_details_response.to_h))
        end

        video_details_response.items.each do |video_item|
          artist = Artist.find_by(channel_id: channel_id)
          if artist
            # ショート動画かどうかを判別する
            video_url = "https://www.youtube.com/shorts/#{video_item.id}"
            video_type = check_if_short_video(video_url) ? :shorts : :normal
            video = KpopVideo.create(
              video_id: video_item.id,
              name: video_item.snippet.title,
              image: video_item.snippet.thumbnails.default.url,
              view_count: video_item.statistics.view_count,
              posted_at: video_item.snippet.published_at,
              artist_id: artist.id,
              video_type: video_type
            )
            video_lists << video
          end
        end
      rescue Google::Apis::ClientError => e
        Rails.logger.error("Error fetching videos for channel #{channel_id}: #{e.message}")
      end
    end

    render json: { videos: video_lists }
  end

  private

  def check_if_short_video(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response.is_a?(Net::HTTPSuccess)
  end
end
