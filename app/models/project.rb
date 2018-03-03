class Project < ApplicationRecord
	has_many :project_files
	has_many :comments
end
