class StoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]


      def index
      	@stories = Story.all.order(id: :desc).page(params[:page]).per(10)
    end

      def show
        @story = Story.find(params[:id])
        @comments = Comment.where(story_id: @story)
      end

      def new
      	@story = Story.new

      end

      def create
         p params[:story][:category_id]
      	@story = Story.new(story_params)
        @story.category_id = params[:story][:category_id]
      	if @story.save
      		redirect_to @story
      	else
      		render 'new'
      	end
      end

      def destroy
        @story = Story.find(params[:id])
           if @story.destroy
            redirect_to root_path
          end
      end

      def upvote 
      @story = Story.find(params[:id])
         @story.upvote_by current_user
         redirect_to :back
      end  

       def downvote
       @story = Story.find(params[:id])
       @story.downvote_by current_user
       redirect_to :back
       end
       def search
        if params[:search]
        @stories = Story.search(params[:search])
      else
    @stories = Story.all
  end
       end


      	private

      	def story_params
      		params.require(:story).permit(:body, :category_id)
      	end

end
