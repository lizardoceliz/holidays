class State < ActiveRecord::Base
  belongs_to :country
  
  validates :name, :presence => true
end
