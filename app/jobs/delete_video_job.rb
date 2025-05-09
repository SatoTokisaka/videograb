class DeleteVideoJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    video = Video.find_by(id: video_id)
    return unless video

    file_path = Rails.root.join("public", "downloads", "video_#{video.id}.mp4")
    File.delete(file_path) if File.exist?(file_path)

    video.destroy
    Rails.logger.info "Deleted video ##{video.id} and its file after 15 minutes"
  end
end
