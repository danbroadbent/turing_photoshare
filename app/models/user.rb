class User < ApplicationRecord

  has_secure_password

  has_many :albums
  has_many :photos

end
