json.array!(@acms) do |acm|
  json.extract! acm, :id, :abstract, :author, :generic_string, :link, :publisher, :pubtitle, :pubtype, :title
  json.url acm_url(acm, format: :json)
end
