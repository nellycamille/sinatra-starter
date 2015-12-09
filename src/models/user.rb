class User < ActiveRecord::Base

  has_many :comments

  validates :username,   presence: true , length: { minimum: 6  }
  validates :password,   presence: true

end
