class Api::V1::PlaylistItemsController < ApplicationController
  before_action :set_current_user

  def index
    playlist = @current_user.playlists.find(params[:playlist_id])
    playlist_items = playlist.playlist_items
    render json: {
      playlist_id: playlist.id,
      playlist_name: playlist.name,
      items: playlist_items.as_json(include: { kpop_video: { only: [:id, :title] } })
    }, status: :ok
  end
  
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
