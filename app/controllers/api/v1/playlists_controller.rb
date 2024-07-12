class Api::V1::PlaylistsController < ApplicationController
  before_action :set_current_user

  def index
    playlists = @current_user.playlists
    render json: playlists
  end

  def create
    playlist = @current_user.playlists.new(playlist_params)

    if playlist.save
      render json: playlist, status: :created
    else
      render json: { errors: playlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    playlist = @current_user.playlists.find(params[:id])
    if playlist.destroy
      render json: { message: 'Playlist successfully deleted' }, status: :ok
    else
      render json: { error: 'Failed to delete playlist' }, status: :unprocessable_entity
    end
  end

  def check_video
    video_id = params[:video_id]
    playlists = @current_user.playlists
    playlist_states = playlists.map do |playlist|
      {
        playlist_id: playlist.id,
        included: playlist.playlist_items.exists?(kpop_video_id: video_id)
      }
    end
    render json: playlist_states, status: :ok
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
