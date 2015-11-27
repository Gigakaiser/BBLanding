class UsersController < ApplicationController
	def home
			session[:refid] = nil
			@referrer = nil
			@newuser = User.new
	end
	def referral_signup
		session[:refid] = params[:userid]
		@referrer = User.where(userid: params[:userid]).first
		@newuser = User.new
		render 'home'
	end

	

	def index
		@users = User.all
	end
	def show
		@user = User.where(userid: params[:userid]).first
		@userrefs = User.where(referrerid: params[:userid])
		@refcount = @userrefs.length;
	end
end