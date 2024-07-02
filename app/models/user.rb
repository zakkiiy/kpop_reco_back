class User < ApplicationRecord
  has_many :favorites
  has_many :kpop_videos, through: :favorites, source: :kpop_video
  has_many :playlists
end
