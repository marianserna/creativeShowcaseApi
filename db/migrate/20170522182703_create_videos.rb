class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.integer :vimeo_id, null: false
      t.string :video_type, null: false
      t.attachment :image, null: false
      t.string :title, null:false
      t.integer :hearts_count, null:false, default: 0

      t.timestamps
    end
  end
end
