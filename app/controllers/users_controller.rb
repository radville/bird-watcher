class UsersController < ApplicationController
    get "/users/signup" do
        if !logged_in?
            erb :'users/signup'
        else
            redirect to "/sightings"
        end
    end

    post "/users/signup" do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/users/signup'
        else
            @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            redirect to '/sightings'
        end
    end

    get "/users/login" do
        if !logged_in?
            erb :"users/login"
        else
            redirect to "/sightings/"
        end
    end

    post "/users/login" do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/sightings'
        else
            redirect to "/users/login"
        end
    end

end