require 'test_helper'

class SongTest < ActiveSupport::TestCase
  test "should not save song without name" do
    song = Song.new
    assert_not song.save
  end
  
  test "should not save song without artist_id" do
    song = Song.new(name: 'Song', artist_id: nil)
    assert_not song.save
  end
  
  test "should not save song with price < 0" do
    song = Song.new(name: 'John', price: -2.3)
    assert_not song.save
  end
  
  test "should save song with null album_id" do
    assert Song.create(name: 'Hello', price: 12.33, artist_id: 1, album_id: nil)
  end
  
  test "should save song with valid values" do
    assert Song.create(name: 'Hello', price: 12.33, artist_id: 1, album_id: 2)
  end
end
