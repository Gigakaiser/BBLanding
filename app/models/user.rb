class User < ActiveRecord::Base
	belongs_to :referred_by, :class_name => "User"
	has_many :referrals, :class_name => "User"
	validates :email, uniqueness: { case_sensitive: false }
	validates :userid, uniqueness: true
end
