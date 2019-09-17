class UsersController < ApplicationController
    get "/users/signup" do
        if !logged_in?
            erb :'users/signup'
        else
            redirect to "/sightings/"
        end
    end

    post "/users/signup" do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            redirect to '/'
        else
            flash[:message] = @user.errors.full_messages.to_sentence
            redirect to '/users/signup'
        end
    end

    get "/users/login" do
        if !logged_in?
            erb :"users/login"
        else
            redirect to "/"
        end
    end

    post "/users/login" do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:message] = "Welcome back, #{user.first_name}!"

            redirect to '/'
        else
            flash[:message] = "Invalid email address or password."
            redirect to "/users/login"
        end
    end

    get "/users/logout" do
        if logged_in?
            session.destroy
            redirect to '/users/login'
        else
            redirect to '/'
        end
    end

end