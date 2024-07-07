class KpopVideo < ApplicationRecord
  belongs_to :artist
  has_many :favorites
  has_many :users, through: :favorites, source: :user
  has_many :playlist_items, dependent: :destroy
  has_many :playlists, through: :playlist_items, source: :playlist

  enum video_type: { normal: 0, shorts: 1 }
end
