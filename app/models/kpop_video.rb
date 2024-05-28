class KpopVideo < ApplicationRecord
  belongs_to :artist

  enum video_type: { normal: 0, shorts: 1 }
end
