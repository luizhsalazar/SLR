json.array!(@references) do |reference|
  json.extract! reference, :id, :query
  json.url reference_url(reference, format: :json)
end
