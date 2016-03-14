class Artist < BaseModel
  has_many :songs
  has_many :albums
  
  validates :name, presence: true
end
