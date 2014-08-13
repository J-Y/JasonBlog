json.array!(@users) do |user|
  json.extract! user, :id, :email, :password, :name, :location, :bio, :website, :avatar_file_name, :state, :qq, :last_logined_at, :tagline
  json.url user_url(user, format: :json)
end
