class AddFormatsToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :formats, :text
  end
end
