class ProjectFile < ApplicationRecord
	belongs_to :project
	has_many :commits
end
