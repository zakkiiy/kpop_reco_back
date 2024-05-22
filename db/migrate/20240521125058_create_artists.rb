class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :channel_id, null: false

      t.timestamps
    end
    
    add_index :artists, :name, unique: true
    add_index :artists, :channel_id, unique: true
  end
end
