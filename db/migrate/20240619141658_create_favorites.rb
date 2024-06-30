class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :kpop_video, null: false, foreign_key: true

      t.timestamps
    end

    add_index :favorites, [:user_id, :kpop_video_id], unique: true
  end
end
