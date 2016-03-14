require 'test_helper'

class AlbumsTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!
  end
  
  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token) 
  end

  test "should throw invalid token" do
    get "/api/albums", {}, {"Authorization" => token_header(@user.auth_token)+"fake"}
    assert_response 401
  end

  test "should get index" do
    get "/api/albums", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
  end
  
  test "should get show" do
    a = Album.create(name: 'ABC', artist_id: 1)
    get "/api/artists/#{a.id}", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
  end
  
  test "should filter by artist_id" do
    Album.create!(name: 'ABC', price: 7, artist_id: 1)
    Album.create!(name: 'XYZ', price: 8, artist_id: 2)
    get "/api/albums?artist_id=1", {}, {"Authorization" => token_header(@user.auth_token)}
    
    albums = JSON.parse(response.body, symbolize_names: true)
    names = albums.flatten[1].collect {|v| v[:name]}
    
    assert_equal ['ABC'].inspect, names.inspect
    assert_not_equal ['XYZ'].inspect, names.inspect
  end
  
  test "should create album" do
    post "/api/albums", 
        {"album" => {"name" =>"Album1", "price" => "12.03", "artist_id" => "1"}}, 
        {"Authorization" => token_header(@user.auth_token)}
    assert_response 201
  end
  
  test "should update album" do
    a = Album.create!(name: 'ABC', price: 7, artist_id: 1)
    patch "/api/albums/#{a.id}", 
        {"album" => {"name" => "XYZ"}}, 
        {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
    assert_equal 'XYZ', a.reload.name
  end
  
  test "should delete album" do
    a = Album.create!(name: 'ABC', price: 7, artist_id: 1)
    delete "/api/albums/#{a.id}", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 204
  end
end
