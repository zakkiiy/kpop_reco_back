class Api::V1::PlaylistItemsController < ApplicationController
  before_action :set_current_user

  def create
    playlist = @current_user.playlists.find(params[:playlist_id])
    playlist_item = playlist.playlist_items.build(kpop_video_id: params[:kpop_video_id])

    if playlist_item.save
      render json: { message: 'Playlist item created successfully' }, status: :created
    else
      render json: { errors: playlist_item.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
