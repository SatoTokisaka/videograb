class VideoProcessorJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    video = Video.find(video_id)

    downloader = VideoDownloaderService.new(video.url)
    info = downloader.metadata

    if info
      # Save metadata
      video.update!(
        title: info["title"],
        thumbnail: info["thumbnail"],
        status: "processing"
      )

      # Build output file path
      output_path = Rails.root.join("public", "downloads")
      FileUtils.mkdir_p(output_path) unless Dir.exist?(output_path)
      filename = output_path.join("video_#{video.id}.mp4")

      # Download the video
      command = [
        "yt-dlp",
        "-f", "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/mp4",
        "-o", filename.to_s,
        video.url
      ]

      if system(*command)
        video.update!(status: "ready")
      else
        Rails.logger.error("yt-dlp failed to download the video for URL: #{video.url}")
        video.update!(status: "error")
      end
    else
      video.update!(status: "error")
    end
  rescue => e
    Rails.logger.error("VideoProcessorJob failed: #{e.message}")
    video.update!(status: "error") if video
  end
end
