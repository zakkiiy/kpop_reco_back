class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :kpop_video
end
