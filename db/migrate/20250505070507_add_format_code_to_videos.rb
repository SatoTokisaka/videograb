class AddFormatCodeToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :format_code, :string
  end
end
