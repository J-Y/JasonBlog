json.array!(@replies) do |reply|
  json.extract! reply, :id, :body, :state, :source
  json.url reply_url(reply, format: :json)
end
