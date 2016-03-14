require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test "should not save artist without name" do
    artist = Artist.new
    assert_not artist.save
  end
  
  test "should save artist with name" do
    artist = Artist.new(name: 'John')
    assert artist.save
  end
end
