json.artists @artists do |artist|
    json.id         artist.id
    json.name       artist.name
    json.birthdate  artist.birthdate
end