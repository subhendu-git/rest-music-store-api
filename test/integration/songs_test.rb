require 'test_helper'

class SongsTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!
  end
  
  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token) 
  end

  test "should throw invalid token" do
    get "/api/songs", {}, {"Authorization" => token_header(@user.auth_token)+"fake"}
    assert_response 401
  end

  test "should get index" do
    get "/api/songs", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
  end
  
  test "should get show" do
    a = Song.create(name: 'ABC', time: 100, price: 2.99, artist_id: 1)
    get "/api/songs/#{a.id}", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
  end
  
  test "should filter by artist_id" do
    Song.create!(name: 'ABC', time: 100, price: 2.99, album_id: 1, artist_id: 1)
    Song.create!(name: 'XYZ', time: 100, price: 2.99, album_id: 2, artist_id: 2)
    get "/api/songs?artist_id=1", {}, {"Authorization" => token_header(@user.auth_token)}
    
    songs = JSON.parse(response.body, symbolize_names: true)
    names = songs.flatten[1].collect {|v| v[:name]}
    
    assert_equal ['ABC'].inspect, names.inspect
    assert_not_equal ['XYZ'].inspect, names.inspect
  end
  
  test "should filter by album_id" do
    Song.create!(name: 'ABC', time: 100, price: 2.99, album_id: 2, artist_id: 1)
    Song.create!(name: 'XYZ', time: 100, price: 2.99, album_id: 3, artist_id: 2)
    get "/api/songs?album_id=2", {}, {"Authorization" => token_header(@user.auth_token)}
    
    albums = JSON.parse(response.body, symbolize_names: true)
    names = albums.flatten[1].collect {|v| v[:name]}
    
    assert_equal ['ABC'].inspect, names.inspect
    assert_not_equal ['XYZ'].inspect, names.inspect
  end
  
  test "should create song" do
    post "/api/songs", 
        {"song" => {"name" =>"Song1", "price" => "12.03", "time" => "100", "album_id"=>"2", "artist_id" => "1"}}, 
        {"Authorization" => token_header(@user.auth_token)}
    assert_response 201
  end
  
  test "should update song" do
    a = Song.create!(name: 'ABC', time: 100, price: 2.99, album_id: 2, artist_id: 1)
    patch "/api/songs/#{a.id}", 
        {"song" => {"name" => "XYZ"}}, 
        {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
    assert_equal 'XYZ', a.reload.name
  end
  
  test "should delete song" do
    a = Song.create!(name: 'ABC', time: 100, price: 2.99, album_id: 2, artist_id: 1)
    delete "/api/songs/#{a.id}", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 204
  end
end
