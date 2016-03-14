json.songs @songs do |song|
    json.id         song.id
    json.name       song.name
    json.genre      song.genre
    json.time       song.time
    json.price      song.price
    json.album_id   song.album_id
    json.artist_id  song.artist_id
end