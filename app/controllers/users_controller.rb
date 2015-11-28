class UsersController < ApplicationController
	def home
		session[:refid] = "NA"
		@referrer = nil
		@newuser = User.new

	end
	def referral_signup

	if User.where(:userid => session[:refid]).blank?
		redirect_to '/'
		flash[:notice] = "Bad rererrer link"
	else

		session[:refid] = params[:userid]
		@referrer = User.where(userid: params[:userid]).first
		@newuser = User.new
		render 'home'
	end
	end
	def create
		 @user = User.new(user_params)
		 @user.userid = SecureRandom.uuid
		 @user.referrerid=session[:refid]
    if @user.save
      redirect_to '/users'
    else
        redirect_to "/"
         flash[:notice] = "Email already registered!"
      
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