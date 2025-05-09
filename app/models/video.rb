class Video < ApplicationRecord
  validates :url, presence: true
  validate :valid_video_url

  def file_path
    "/downloads/video_#{id}.mp4"
  end

  def file_path_for(quality)
    # Temporarily hardcode to avoid quality_files access
    "/downloads/video_#{id}_#{quality}.mp4"
    # quality_files[quality] || file_path
  end

  private

  def valid_video_url
    unless url.match?(/\Ahttps:\/\/(www\.)?[\w-]+\.[\w-]+(\/.*)?\z/)
      errors.add(:url, "must be a valid HTTPS URL")
    end
  end
end
