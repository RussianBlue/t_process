json.array!(@progresses) do |progress|
  json.extract! progress, :id, :project_id, :curriculum_id, :lesson, :process, :progress_type_id, :status
  json.url progress_url(progress, format: :json)
end
