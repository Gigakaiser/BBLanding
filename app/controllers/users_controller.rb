class UsersController < ApplicationController
	def home
		session[:refid] = nil
		@referrer = nil
			@newuser = User.new
	end
	def referral_signup
		session[:refid] = params[:userid]
		@referrer = User.where(userid: params[:userid]).first
		render 'home'
		@newuser = User.new
	end
	
	def create
		 @user = User.new(user_params)
    if @user.save
      redirect_to '/users'
    else
       redirect_to '/'
		end
	
	end
	def update
			redirect_to '/'
	end

	def index
		@users = User.all
	end
	def show
		@user = User.where(userid: params[:userid]).first
		@userrefs = User.where(referrerid: params[:userid])
		@refcount = @userrefs.length;
	end
	def user_params
		 params.require(:user).permit(:email)
	end
end