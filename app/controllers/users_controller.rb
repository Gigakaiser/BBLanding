class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def show
		@user = User.where(userid: params[:userid]).first
		@userrefs = User.where(referrerid: params[:userid])
		@refcount = @userrefs.length;
	end
end