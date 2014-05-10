class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: :create
	
	def create
		if params[:password_conf] == params[:password]
			User.create(
				:login 	  => params[:login],
			 	:password => Digest::SHA256.hexdigest(params[:password]),
			 	:email    => params[:email]
			)
		else
			redirect_to :back			
		end
	end

	def show
	  	if params[:type] == "1"
	  		#type 1 is search by site name ;D
	  		@passwords = Credential.find_by_sql "select * from credentials where user_id = #{session[:user_id]} and site like '%#{params[:search]}%'" 
	  	elsif params[:type] == "2"
	  		#type 1 is search by login
	  		@passwords = Credential.find_by_sql "select * from credentials where user_id = #{session[:user_id]} and login like '%#{params[:search]}%'" 
	  	elsif params[:type] == "3"
	  		#type 1 is search by password
	  		#needed?
	  		@passwords = Credential.find_by_sql "select * from credentials where user_id = #{session[:user_id]} and password like '%#{params[:search]}%'"
	  	else
	  		#search all
	  		@passwords = Credential.find_all_by_user_id(session[:user_id])
	  	end
	end

end