class CreatePlaylistItems < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_items do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :kpop_video, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
    add_index :playlist_items, [:playlist_id, :kpop_video_id], unique: true
  end
end
