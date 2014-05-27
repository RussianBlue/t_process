json.array!(@projects) do |project|
  json.extract! project, :id, :years, :title, :p_code, :finish, :finished_at, :width, :height
  json.url project_url(project, format: :json)
end
