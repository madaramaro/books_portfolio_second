class PostsController < ApplicationController
    before_action :authenticate_user!
    def index
        render :index
    end

    def new
        render :new
    end

    def create
        redirect_to new_post_path
    end
end
