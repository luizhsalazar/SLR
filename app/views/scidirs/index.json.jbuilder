json.array!(@scidirs) do |scidir|
  json.extract! scidir, :id, :abstract, :author, :generic_string, :link, :publisher, :pubtitle, :pubtype, :title
  json.url scidir_url(scidir, format: :json)
end
