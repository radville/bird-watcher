class BirdSightingsController < ApplicationController
    get "/sightings/" do
        redirect_if_not_logged_in
        
        @sightings = BirdSighting.all
            .select {|sighting| sighting.user_id == session[:user_id]} 
            .sort_by { |sighting| sighting.common_name}

        erb :"bird_sightings/index"
    end
    
    post "/sightings/" do
        redirect_if_not_logged_in

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
    end

    get "/sightings/new" do
        redirect_if_not_logged_in
        
        erb :"bird_sightings/new"
    end

    get "/sightings/choose" do
        redirect_if_not_logged_in

        @birds = Bird.all
        erb :"bird_sightings/choose_bird"
    end

    post "/sightings/choose" do
        redirect_if_not_logged_in

        if params[:search] != ""
            redirect to "/sightings/choose/#{params[:search].downcase.gsub(" ","-")}"
        else
            flash[:message] = "Please enter search terms."
            redirect to "/sightings/choose"
        end
    end

    get "/sightings/choose/:slug" do
        redirect_if_not_logged_in
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
    end
    
    get "/sightings/:slug" do
        redirect_if_not_logged_in
        @session = session
        @sighting = BirdSighting.find_by_slug_user(params[:slug], @session[:user_id])

        erb :"bird_sightings/show"
    end
    
    get "/sightings/:slug/edit" do
        redirect_if_not_logged_in
        
        @sighting = BirdSighting.find_by_slug_user(params[:slug], session[:user_id])
        if @sighting && @sighting.user == current_user
            erb :"bird_sightings/edit"
        else
            redirect to "/sightings/"
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
        redirect_if_not_logged_in
        sighting = BirdSighting.find_by_slug_user(params[:slug], session[:user_id])
        if sighting && sighting.user == current_user
            sighting.delete
        else
            flash[:message] = "Bird sighting not found in your list."
            redirect to "/sightings/:slug/"
        end
        redirect to "/sightings/"
    end

    get '/*' do
        erb :not_found
    end

end