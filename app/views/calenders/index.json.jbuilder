json.array!(@calenders) do |calender|
  json.extract! calender, :id, :title, :type, :start_at, :end_at
  json.url calender_url(calender, format: :json)
end
