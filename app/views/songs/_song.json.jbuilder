json.extract! song, :id, :title, :artist, :upvotes, :played, :created_at, :updated_at
json.url song_url(song, format: :json)
