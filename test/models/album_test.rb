require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  test "should not save album without name" do
    album = Album.new
    assert_not album.save
  end
  
  test "should not save album without artist_id" do
    album = Album.new(name: 'John')
    assert_not album.save
  end
  
  test "should not save album with price < 0" do
    album = Album.new(name: 'John', price: -2.3)
    assert_not album.save
  end
  
  test "should save album with valid values" do
    assert Album.create(name: 'Hello', price: 12.33, artist_id: 1)
  end
end
