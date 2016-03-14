class Album < BaseModel
  belongs_to :artist
  has_many :songs
  
  validates :name, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :artist_id, presence: {allow_null: false}
end
