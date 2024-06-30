class KpopVideo < ApplicationRecord
  belongs_to :artist
  has_many :favorites
  has_many :users, through: :favorites, source: :user

  enum video_type: { normal: 0, shorts: 1 }
end
