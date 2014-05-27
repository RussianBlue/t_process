json.array!(@curriculums) do |curriculum|
  json.extract! curriculum, :id, :project_id, :total, :title, :c_code, :location, :start, :progress_type_ids, :width, :height
  json.url curriculum_url(curriculum, format: :json)
end
