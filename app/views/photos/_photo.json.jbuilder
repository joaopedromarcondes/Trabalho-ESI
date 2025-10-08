json.extract! photo, :id, :foto, :latitude, :longitude, :created_at, :updated_at
json.url photo_url(photo, format: :json)
json.foto url_for(photo.foto)
