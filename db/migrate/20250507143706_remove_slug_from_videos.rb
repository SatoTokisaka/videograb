class RemoveSlugFromVideos < ActiveRecord::Migration[8.0]
  def change
    remove_column :videos, :slug, :string
  end
end
