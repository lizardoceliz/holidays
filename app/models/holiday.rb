class Holiday < ActiveRecord::Base
  belongs_to :user
  
  validates :name, :month, :day, :presence => true
  validates :month, :inclusion => { :in => 1..12 }
  validates :day, :inclusion => { :in => 1..31 }
end
