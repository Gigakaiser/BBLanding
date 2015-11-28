class User < ActiveRecord::Base
	belongs_to :referred_by, :class_name => "User"
	has_many :referrals, :class_name => "User"
	#validates_uniqueness_of :email
	
end
