class CreateKpopVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :kpop_videos do |t|
      t.string :name, null: false
      t.string :video_id, null: false
      t.string :image, null: false
      t.bigint :view_count, null: false
      t.datetime :posted_at, null:false
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end

    add_index :kpop_videos, :video_id, unique: true
  end
end
