json.array!(@messages) do |message|
  json.extract! message, :id, :project_id, :user_id, :m_type, :to, :from, :content
  json.url message_url(message, format: :json)
end
