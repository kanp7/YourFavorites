class SearchesController < ApplicationController

	def search
		@select_model = params[:select_model]
		@word = params[:word]
		if @select_model == 'user'
			return if @word.blank?

			@users = User.search(@word).page(params[:page])
		else
			return if @word.blank?

			@posts = Post.search(@word).page(params[:page])
		end
	end

end
