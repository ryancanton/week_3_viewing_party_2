class ViewingPartiesController < ApplicationController 
    before_action :validate_vp_creation, only: :new
    def new
        @user = User.find(params[:user_id])
        @movie = Movie.find(params[:movie_id])
    end 
    
    def create 
        user = User.find(params[:user_id])
        user.viewing_parties.create(viewing_party_params)
        redirect_to "/users/#{params[:user_id]}"
    end 

    private 

    def viewing_party_params 
        params.permit(:movie_id, :duration, :date, :time)
    end 

    def validate_vp_creation
        unless session[:user_id]
            flash[:errors] = "You must be a registered user to create a viewing party"
            redirect_to movie_path(params[:user_id], params[:movie_id])
        end
      end
end 