class BirdSightingsController < ApplicationController
    
    get "/sightings/" do
        if logged_in?
            erb :"bird_sightings/index"
        else
            redirect to "/users/login"
        end
    end
    
    post "/sightings/" do
        sighting = BirdSighting.create(common_name: params[:common_name], scientific_name: params[:scientific_name], \
            date: params[:date], time: params[:time], location: params[:location], description: params[:description], \
            user_id: session[:user_id])
    
        redirect to "/sightings/#{sighting.id}"
    end

    get "/sightings/new" do
        if logged_in?
            erb :"bird_sightings/new"
        else
            redirect to "/users/login"
        end
    end
    
    get "/sightings/:id" do
        if logged_in?
            @sighting = BirdSighting.find_by_id(params[:id])
            erb :"bird_sightings/show"
        else
            redirect to "/users/login"
        end
    end
    
    get "/sightings/:id/edit" do
        if logged_in?
            @sighting = BirdSighting.find_by_id(params[:id])
    
            erb :"bird_sightings/edit"
        else
            redirect to "/users/login"
        end
    end
    
    patch "/sightings/:id" do
        sighting = BirdSighting.find_by_id(params[:id])
        
        sighting.update(common_name: params[:common_name]) if params[:common_name] != "" 
        sighting.update(scientific_name: params[:scientific_name]) if params[:scientific_name] != "" 
        sighting.update(date: params[:date]) if params[:date] != "" 
        sighting.update(time: params[:time]) if params[:time] != "" 
        sighting.update(location: params[:location]) if params[:location] != "" 
        sighting.update(description: params[:description]) if params[:description] != "" 
    
        redirect to "/sightings/#{sighting.id}"
    end
    
    delete "/sightings/:id/delete" do
        sighting = BirdSighting.find_by_id(params[:id])
        sighting.delete

        redirect to "/sightings/"
    end

end