json.extract! token, :id, :code, :created_at, :updated_at
json.url token_url(token, format: :json)
