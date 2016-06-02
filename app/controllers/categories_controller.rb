class CategoriesController < ApplicationController

	def show
		
			@category_id = Category.find(params[:id])
			@stories = Story.where(:category_id => @category_id).order("created_at DESC")
		end
end
