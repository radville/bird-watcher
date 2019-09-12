class BirdSightingsController < ApplicationController
    get "/sightings/" do
        if logged_in?
            @sightings = BirdSighting.all
                .select {|sighting| sighting.user_id == session[:user_id]} 
                .sort_by { |sighting| sighting.common_name}

            erb :"bird_sightings/index"
        else
            redirect to "/users/login"
        end
    end
    
    post "/sightings/" do
        if logged_in? 
            if params[:common_name] != ""
                sighting = BirdSighting.create(common_name: params[:common_name], scientific_name: params[:scientific_name], \
                    datetime: params[:datetime], location: params[:location], description: params[:description], \
                    credit: params[:credit], img_src: params[:img_src], license_url: params[:license_url], \
                    order: params[:order], family: params[:family], user_id: session[:user_id])
                    
                flash[:message] = "Successfully added to your list!"
                redirect to "/sightings/#{sighting.slug}"
            else
                flash[:message] = "Please enter the bird's common name."
                redirect to "/sightings/new"
            end
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

    post "/sightings/choose" do
        if logged_in?
            if params[:search] != ""
                redirect to "/sightings/choose/#{params[:search].downcase.gsub(" ","-")}"
            else
                flash[:message] = "Please enter search terms."
                redirect to "/sightings/choose"
            end
        else
            redirect to "/users/login"
        end
    end

    get "/sightings/choose/:slug" do
        if logged_in?
            @search_terms = params[:slug].gsub("-"," ")
            @birds = []
            @search_terms.split(" ").each do |term|
                @birds.concat Bird.all.select { |bird| 
                    bird.common_name.downcase.include?(term) ||
                    bird.scientific_name.downcase.include?(term) ||
                    bird.order.downcase.include?(term) ||
                    bird.family.downcase.include?(term)
                }
            end

            erb :"bird_sightings/choose_bird"
        else
            redirect to "/users/login"
        end
    end
    
    get "/sightings/:slug" do
        if logged_in?
            @session = session
            @sighting = BirdSighting.find_by_slug_user(params[:slug], @session[:user_id])

            erb :"bird_sightings/show"
        else
            redirect to "/users/login"
        end
    end
    
    get "/sightings/:slug/edit" do
        if logged_in?
            @sighting = BirdSighting.find_by_slug_user(params[:slug], session[:user_id])
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
            sighting = BirdSighting.find_by_slug_user(params[:slug], session[:user_id])
            if sighting && sighting.user == current_user
                sighting.update(common_name: params[:common_name]) if params[:common_name] != "" 
                sighting.update(scientific_name: params[:scientific_name]) if params[:scientific_name] != "" 
                sighting.update(datetime: params[:datetime]) if params[:datetime] != "" 
                sighting.update(location: params[:location]) if params[:location] != "" 
                sighting.update(description: params[:description]) if params[:description] != "" 
                sighting.update(datetime: params[:datetime]) if params[:datetime] != "" 
                sighting.update(img_src: params[:img_src]) if params[:img_src] != ""

                flash[:message] = "Successfully edited!"

                redirect to "/sightings/#{sighting.slug}"
            else
                flash[:message] = "Bird sighting not found in your list."

                redirect to "/sightings/:slug/edit"
            end
        end
    end
    
    get "/sightings/:slug/delete" do
        if logged_in?
            sighting = BirdSighting.find_by_slug_user(params[:slug], session[:user_id])
            if sighting && sighting.user == current_user
                sighting.delete
            else
                flash[:message] = "Bird sighting not found in your list."
                redirect to "/sightings/:slug/"
            end
            redirect to "/sightings/"
        else
            redirect to "users/login"
        end
    end

end