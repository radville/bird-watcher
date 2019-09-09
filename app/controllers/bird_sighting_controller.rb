class BirdSightingsController < ApplicationController
    get "/sightings/new" do
        erb :"bird_sightings/new"
    end
    
    get "/sightings" do
        erb :"bird_sightings/index"
    end
    
    post "/sightings" do
    
        redirect to "/sightings/#{sighting.id}"
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