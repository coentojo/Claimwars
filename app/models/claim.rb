class Claim < ActiveRecord::Base
  validates_uniqueness_of :sid, :scope => [:uid]
  
end
