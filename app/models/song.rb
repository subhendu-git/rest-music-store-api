class Song < BaseModel
  belongs_to :artist
  belongs_to :album
  
  validates :name, presence: true
  validates :price, :time, numericality: {greater_than_or_equal_to: 0}
  validates :album_id, presence: {allow_null: true}
  validates :artist_id, presence: {allow_null: false}
end
