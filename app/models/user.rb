class User < ActiveRecord::Base
  before_create -> {self.auth_token = SecureRandom.hex}
end
