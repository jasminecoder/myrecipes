class ChatroomsController < ApplicationController  
    before_action :require_user
    
    def show
        @message = Message.new
        @messages = Message.all
    end
end