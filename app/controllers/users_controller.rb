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
    elsif User.where(:email => @user.email).first.blank?
	     redirect_to "/"
        flash[:notice] = "Error!" 
    else
    	@olduser =  User.where(:email => @user.email).first
    	redirect_to "/tracker/#{@olduser.userid}"
    		
    	
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
		@reflink = URI.join(root_url,@user.userid)
		@refcount = @userrefs.length
		startfill = 10
		goal1 = 5
		goal2 = 10
		goal3 = 25
		goal4 = 50

		mark1 = 29.0
		mark2 = 50.0
		mark3 = 70.5
		mark4 = 92.3

		if @refcount <= goal1
			@percentage = startfill + (@refcount * (mark1-startfill)/(goal1-0))
		
		elsif @refcount <= goal2
			@percentage = mark1 + ((@refcount-goal1) * (mark2-mark1)/(goal2-goal1))
		
		elsif @refcount <= goal3
			@percentage = mark2 + ((@refcount-goal2) * (mark3-mark2)/(goal3-goal2))
		
		elsif @refcount <= goal4-1
			@percentage = mark3 + ((@refcount-goal3) * (mark4-mark3)/(goal4-goal3))
		elsif @refcount >= goal4
			@percentage = 100
		
	end
		#@percentage = ((six/50.0)*100)
		
		render 'showstats'
	end
	def user_params
		 params.require(:user).permit(:email)
	end
end