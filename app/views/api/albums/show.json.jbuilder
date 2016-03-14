json.album do
    json.id         @album.id
    json.name       @album.name
    json.price      @album.price
    json.artist_id  @album.artist_id
end