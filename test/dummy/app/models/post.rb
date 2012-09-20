class Post < ActiveRecord::Base
  attr_accessible :author, :name
  
  scope :sorted, order("id desc")
end
