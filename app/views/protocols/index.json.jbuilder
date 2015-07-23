json.array!(@protocols) do |protocol|
  json.extract! protocol, :id, :title, :background, :research_question, :strategy, :criteria
  json.url protocol_url(protocol, format: :json)
end
