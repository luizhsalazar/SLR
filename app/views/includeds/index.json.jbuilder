json.array!(@includeds) do |included|
  json.extract! included, :id, :title, :author, :pubtitle, :included, :protocol_id
  json.url included_url(included, format: :json)
end
