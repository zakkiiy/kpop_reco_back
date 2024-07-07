class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_items, dependent: :destroy
  has_many :kpop_videos, through: :playlist_items, source: :kpop_video
end
