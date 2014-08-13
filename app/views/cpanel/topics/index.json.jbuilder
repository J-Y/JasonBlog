json.array!(@topics) do |topic|
  json.extract! topic, :id, :title, :body, :replies_count, :last_reply_user_id, :replied_at, :source
  json.url topic_url(topic, format: :json)
end
