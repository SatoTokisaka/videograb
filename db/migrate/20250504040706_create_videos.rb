class CreateVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos do |t|
      t.string :url
      t.string :title
      t.string :thumbnail
      t.string :status

      t.timestamps
    end
  end
end
