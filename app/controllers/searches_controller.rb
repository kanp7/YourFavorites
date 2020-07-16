class SearchesController < ApplicationController

	def search
		@select_model = params[:select_model]
		@word = params[:word]

		if @select_model == '1'
			@user = User.search(@word)
		else
			@post = Post.search(@word)
		end
	end
end
