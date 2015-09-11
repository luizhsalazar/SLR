json.array!(@google_scholars) do |google_scholar|
  json.extract! google_scholar, :id, :abstract, :author, :link, :publisher, :pubtitle, :pubtype, :title, :protocol_id, :included, :selected
  json.url google_scholar_url(google_scholar, format: :json)
end
