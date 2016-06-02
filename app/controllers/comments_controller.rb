class CommentsController < ApplicationController
	before_action :find_story, only: [:create]
	before_action :find_comment, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]


	def new
		@comment = Comment.new
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.story_id = @story.id
		@comment.user_id = current_user.id

		if @comment.save
			redirect_to story_path(@story)
		else
			render 'new'
		end
	end
	

	def edit
	end

	def update
		if @comment.update(comment_params)
			redirect_to story_path(@story)
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		redirect_to story_path(@story)
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def find_comment
		@comment = Comment.find(params[:id])
	end
	def find_story
			@story = Story.find(params[:story_id])
		end
     
end

