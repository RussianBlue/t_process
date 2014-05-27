json.array!(@products) do |product|
  json.extract! product, :id, :curriculum_id, :lesson, :content_use, :p_data, :s_data
  json.url product_url(product, format: :json)
end
