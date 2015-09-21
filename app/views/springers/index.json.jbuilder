json.array!(@springers) do |springer|
  json.extract! springer, :id, :abstract, :author, :link, :publisher, :pubtitle, :pubtype, :title, :protocol_id, :included, :selected
  json.url springer_url(springer, format: :json)
end
