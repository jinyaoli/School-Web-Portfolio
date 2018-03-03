class Comment < ApplicationRecord
	belongs_to :project
	has_many :sub_comments, class_name: "Comment", foreign_key: :comment_id

	has_many :upvotes, class_name: "UpVote"

	def comment
		Comment.find(self.comment_id)
	end
end


