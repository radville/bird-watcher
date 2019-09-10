class BirdSightingsController < ApplicationController
    
    get "/sightings/" do
        erb :"bird_sightings/index"
    end
    
    post "/sightings/" do
        sighting = BirdSighting.create(common_name: params[:common_name], scientific_name: params[:scientific_name], \
            date: params[:date], time: params[:time], location: params[:location], description: params[:description], \
            user_id: session[:user_id])
    
        redirect to "/sightings/#{sighting.id}"
    end

    get "/sightings/new" do
        erb :"bird_sightings/new"
    end
    
    get "/sightings/:id" do
        @sighting = BirdSighting.find_by_id(params[:id])
        erb :"bird_sightings/show"
    end
    
    get "/sightings/:id/edit" do
        @sighting = BirdSighting.find_by_id(params[:id])
    
        erb :"bird_sightings/edit"
    end
    
    patch "/sightings/:id" do
        sighting = BirdSighting.find_by_id(params[:id])
        sighting.update()
    
        redirect to "/sightings/#{sighting.id}"
    end
    
    delete "/sightings/:id" do
        sighting = BirdSighting.find_by_id(params[:id])
        sighting.delete

        redirect to "/sightings"
    end

end