# Database design
# ---------------
# Artist
# ---------------------------------
# id   |   name       | birthday
# ---------------------------------
# 1    | Chris Martin | 03/02/1977
# 2    | Adele        | 05/05/1988
# 3    | Bob Dylan    | 05/22/1941
# ---------------------------------
#
# Album
# ----------------------------------------------
# id  | name                | price | artist_id
# ----------------------------------------------
# 1   | Highway 61          | 6.99  |   3
# 2   | Ghost Stories       | 9.99  |   1
# 3   | The Only Way is Up  | 12.53 |   2
# 4   | Parachutes          | 15.02 |   1
# ----------------------------------------------
#
# Song 
# ----------------------------------------------------------------------------------------
# id | name                         | genre         | time  | price | album_id | artist_id
# ----------------------------------------------------------------------------------------
# 1  | Like a rolling stone         | Rock and Roll | 3:51  | 2.99  |    1     |    3
# 2  | Skyfall                      | Pop           | 4:01  | 3.01  |    3     |    2
# 3  | Viva la Vida                 | Rock          | 4:03  | 2.53  |    2     |    1
# 4  | Tambourine Man               | Rock and Roll | 2:58  | 1.88  |    1     |    3
# 5  | Fix You                      | Rock          | 4:55  | 2.11  |    4     |    1
# 6  | Someone like you             | Pop           | 5:03  | 3.19  |    3     |    2
# 7  | The Scientist                | Rock          | 4:32  | 2.99  |    2     |    1
# ----------------------------------------------------------------------------------------


d1 = Date.new(1977, 3, 2)
d2 = Date.new(1988, 5, 5)
d3 = Date.new(1941, 5, 24)

artist1 = Artist.create(name: 'Chris Martin', birthdate: d1)
artist2 = Artist.create(name: 'Adele', birthdate: d2)
artist3 = Artist.create(name: 'Bob Dylan', birthdate: d3)

album1 = Album.create(name: 'Highway 61', price: 6.99, artist: artist3)
album2 = Album.create(name: 'Ghost Stories', price: 9.99, artist: artist1)
album3 = Album.create(name: 'The Only Way is Up', price: 12.53, artist: artist2)
album4 = Album.create(name: 'Parachutes', price: 15.02, artist: artist1)


Song.create(name: 'Like a rolling stone', genre: 'Rock and Roll', time: 231, price: 2.99, album: album1, artist: artist3)
Song.create(name: 'Skyfall', genre: 'Pop', time: 241, price: 3.01, album: album3, artist: artist2)
Song.create(name: 'Viva la Vida', genre: 'Rock', time: 243, price: 2.53, album: album2, artist: artist1)
Song.create(name: 'Tambourine Man', genre: 'Rock and Roll', time: 178, price: 1.88, album: album1, artist: artist3)
Song.create(name: 'Fix You', genre: 'Rock', time: 295, price: 2.11, album: album4, artist: artist1)
Song.create(name: 'Someone like you', genre: 'Pop', time: 303, price: 3.19, album: album3, artist: artist2)
Song.create(name: 'The Scientist', genre: 'Rock', time: 272, price: 2.99, album: album2, artist: artist1)

User.create(login: 'test', password: '1234')