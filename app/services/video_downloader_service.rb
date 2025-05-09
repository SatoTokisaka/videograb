class VideoDownloaderService
  def initialize(url)
    @url = url
  end

  def metadata
    output = `yt-dlp --dump-json "#{@url}" 2>&1`
    if output.include?("ERROR")
      Rails.logger.error("yt-dlp metadata fetch failed for URL: #{@url}. Output: #{output}")
      raise "URL not supported or invalid. Please check the URL and try again."
    end

    JSON.parse(output)
  rescue JSON::ParserError => e
    Rails.logger.error("yt-dlp metadata parse error: #{e.message}")
    Rails.logger.error("Raw output: #{output}")
    nil
  rescue => e
    Rails.logger.error("Error in metadata: #{e.message}")
    nil
  end
end
