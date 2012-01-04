class Customer < ActiveRecord::Base
  belongs_to :user
  
  validates :name, :email, :presence => true
  validates :remember_me, :inclusion => { :in => [true, false] }   
end