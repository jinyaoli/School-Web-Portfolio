class UpVotesController < ApplicationController
	def create
		@upvote = UpVote.new(comment_id: params[:comment_id])
		if @upvote.save
			render json: {status: :ok}
		else 
			render json: {status: "400"}
		end
	end
end
