require 'test_helper'

class ArtistsTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!
  end
  
  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token) 
  end

  test "should throw invalid token" do
    get "/api/artists", {}, {"Authorization" => token_header(@user.auth_token)+"fake"}
    assert_response 401
  end

  test "should get index" do
    get "/api/artists", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
  end
  
  test "should get show" do
    a = Artist.create(name: 'ABC')
    get "/api/artists/#{a.id}", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
  end
  
  test "should create artist" do
    #a = Artist.create(name: 'ABC')
    post "/api/artists", 
        {"artist" => {"name" =>"Jim"}}, 
        {"Authorization" => token_header(@user.auth_token)}
    assert_response 201
  end
  
  test "should update artist" do
    a = Artist.create(name: 'ABC')
    patch "/api/artists/#{a.id}", 
        {"artist" => {"name" =>"Jim"}}, 
        {"Authorization" => token_header(@user.auth_token)}
    assert_response 200
    assert_equal 'Jim', a.reload.name
  end
  
  test "should delete artist" do
    a = Artist.create(name: 'ABC')
    delete "/api/artists/#{a.id}", {}, {"Authorization" => token_header(@user.auth_token)}
    assert_response 204
  end
end
