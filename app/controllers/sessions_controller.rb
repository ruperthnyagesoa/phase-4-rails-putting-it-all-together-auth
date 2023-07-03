class SessionsController < ApplicationController
    wrap_parameters format: []

    def create   
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
        user = User.new
            user.validate
            render json: {errors: user.errors.full_messages}, status: :unauthorized
        end
    end 

    def destroy

        user = User.find_by(id: session[:user_id])

        if user
            session.delete :user_id
            head :no_content
        else
            user = User.new 
            user.validate
            render json: {errors: user.errors.full_messages}, status: :unauthorized
        end
    end

end