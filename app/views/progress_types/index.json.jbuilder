json.array!(@progress_types) do |progress_type|
  json.extract! progress_type, :id, :name
  json.url progress_type_url(progress_type, format: :json)
end
