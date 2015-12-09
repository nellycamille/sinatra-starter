class Comment < ActiveRecord::Base

  belongs_to :lead
  belongs_to :user

end
