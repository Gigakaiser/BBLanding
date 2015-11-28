class UsersController < ApplicationController
	def home
		session[:refid] = "NA"
		@referrer = nil
		@newuser = User.new
	end

	def referral_signup
	session[:refid] = params[:userid]
	if User.where(:userid => session[:refid]).first.blank?
		session[:refid] ="NA"
		redirect_to '/'
		flash[:notice] = "Bad rererrer link"
	else
		
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
      redirect_to "/tracker/#{@user.userid}"
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
	def showstats
		@user = User.where(userid: params[:userid]).first
		@userrefs = User.where(referrerid: params[:userid])
		@refcount = @userrefs.length;
		@percentage = ((@refcount/50.0)*100)
		@reflink = URI.join(root_url,@user.userid)
		render 'showstats'
	end
	def user_params
		 params.require(:user).permit(:email)
	end
end