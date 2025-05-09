json.extract! video, :id, :url, :title, :thumbnail, :status, :created_at, :updated_at
json.url video_url(video, format: :json)
