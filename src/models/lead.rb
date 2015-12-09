class Lead < ActiveRecord::Base
  has_many :comments
  validates :name, :email, :servicio , presence: true

end
