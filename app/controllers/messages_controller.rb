class MessagesController < ApplicationController
	def new
		@recipient = User.find(params[:to])
		@message = Message.new
	end

	def create 
		@message = Message.new
		@message.subject   = params[:message][:subject]
		@message.body      = params[:message][:body]
		@message.recipient = User.find(2)
		@message.sender    = User.find(session[:user_id])


		if @message.save
			redirect_to @message
		end
	end

	def show
		@message = Message.find(params[:id])

		if @message.sender_id == session[:user_id] or @message.recipient_id == session[:user_id]
			Message.read_message(@message.id, User.find(session[:user_id])) if @message.recipient_id == session[:user_id]
			@message
		else
			redirect_to :back
		end
	end

	def index
		user = User.find(session[:user_id])
		@received_messages = user.received_messages
	end
end