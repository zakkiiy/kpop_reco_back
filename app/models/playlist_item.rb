class PlaylistItem < ApplicationRecord
  belongs_to :playlist
  belongs_to :kpop_video
end
