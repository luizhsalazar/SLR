json.array!(@scopus) do |scopu|
  json.extract! scopu, :id, :abstract, :author, :link, :publisher, :pubtitle, :pubtype, :title
  json.url scopu_url(scopu, format: :json)
end
