class UsersController < ApplicationController
    get "/users/signup" do
        if !logged_in?
            erb :'users/signup'
        else
            redirect to "/sightings/"
        end
    end

    post "/users/signup" do
        if params[:first_name] == "" || params[:email] == "" || params[:password] == ""
            flash[:message] = "Please enter valid first name, email address, and password."
            redirect to '/users/signup'
        elsif User.all.any? { |user| user.email == params[:email]}
            flash[:message] = "Email address already has an account."
            redirect to '/users/login'
        else
            @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            
            flash[:message] = "Welcome, #{@user.first_name}! Successfully created account."
            redirect to '/'
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
            puts session
            session.destroy
            redirect to '/users/login'
        else
            redirect to '/'
        end
    end

end