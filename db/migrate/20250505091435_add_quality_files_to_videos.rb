class AddQualityFilesToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :quality_files, :text
  end
end
