class OccurenceArchivingsController < ApplicationController
    before_action :authenticate_user!

    def create
        o = Occurence.find(params[:occurence_id])
        if o.active? && can?(:archive, o)
            o.archive!
            flash[:success] = "Occurence was successfully archived!" 
        elsif o.archived? && can?(:activate, o)
            o.activate!
            flash[:success] = "Occurence status was set to active successfully!"
        else
            flash[:danger] = "Access Denied!"
        end

        redirect_to occurences_path
    end
end
