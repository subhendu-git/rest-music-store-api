class BaseModel < ActiveRecord::Base
  self.abstract_class = true

  def self.find_unarchived(id)
    find_by(id: id, archived: false)
  end
  
  def archive
    self.archived = true
    self.save
  end 
end