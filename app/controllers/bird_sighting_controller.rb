require 'sinatra/base'
require 'rack-flash'

class BirdSightingsController < ApplicationController
    use Rack::Flash

    get "/sightings/" do
        if logged_in?
            @sightings = BirdSighting.all.select {|sighting| sighting.user_id == session[:user_id]}
            erb :"bird_sightings/index"
        else
            redirect to "/users/login"
        end
    end
    
    post "/sightings/" do
        if logged_in? && params[:common_name] != ""

            sighting = BirdSighting.create(common_name: params[:common_name], scientific_name: params[:scientific_name], \
                datetime: params[:datetime], location: params[:location], description: params[:description], \
                credit: params[:credit], img_src: params[:img_src], license_url: params[:license_url], \
                order: params[:order], family: params[:family], user_id: session[:user_id])
                
            flash[:message] = "Successfully added a bird sighting!"
            redirect to "/sightings/#{sighting.slug}"
        else
            redirect to "/users/login"
        end
    end

    get "/sightings/new" do
        if logged_in?
            erb :"bird_sightings/new"
        else
            redirect to "/users/login"
        end
    end

    get "/sightings/choose" do
        if logged_in?
            @birds = Bird.all
            erb :"bird_sightings/choose_bird"
        else
            redirect to "/users/login"
        end
    end
    
    get "/sightings/:slug" do
        if logged_in?
            @sighting = BirdSighting.find_by_slug(params[:slug])
            erb :"bird_sightings/show"
        else
            redirect to "/users/login"
        end
    end
    
    get "/sightings/:slug/edit" do
        if logged_in?
            @sighting = BirdSighting.find_by_slug(params[:slug])
            if @sighting && @sighting.user == current_user
                erb :"bird_sightings/edit"
            else
                redirect to "/sightings/"
            end
        else
            redirect to "/users/login"
        end
    end
    
    patch "/sightings/:slug" do
        if logged_in?
            sighting = BirdSighting.find_by_slug(params[:slug])
            if sighting && sighting.user == current_user && params[:common_name] != ""
                flash[:message] = "Successfully edited bird sighting!"

                sighting.update(common_name: params[:common_name]) if params[:common_name] != "" 
                sighting.update(scientific_name: params[:scientific_name]) if params[:scientific_name] != "" 
                sighting.update(datetime: params[:datetime]) if params[:datetime] != "" 
                sighting.update(location: params[:location]) if params[:location] != "" 
                sighting.update(description: params[:description]) if params[:description] != "" 
                sighting.update(datetime: params[:datetime]) if params[:datetime] != "" 
                sighting.update(img_src: params[:img_src]) if params[:img_src] != "" 
    
                redirect to "/sightings/#{sighting.slug}"
            else
                redirect to "/sightings/"
            end
        end
    end
    
    get "/sightings/:slug/delete" do
        if logged_in?
            sighting = BirdSighting.find_by_slug(params[:slug])
            if sighting && sighting.user == current_user
                sighting.delete
            end
            redirect to "/sightings/"
        else
            redirect to "users/login"
        end
    end

end