json.extract! user, :id, :name, :email, :bodyweight
json.url user_url(user, format: :json)
