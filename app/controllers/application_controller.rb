require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
    register Sinatra::Flash
  end

  get "/" do
    @birds = Bird.all
    erb :welcome
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def redirect_if_not_logged_in
      redirect to '/users/login' unless logged_in?
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end 
  end

end
