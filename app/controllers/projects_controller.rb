class ProjectsController < ApplicationController
  
  def show
  	@project = Project.find(params[:id])
  	@project_files = @project.project_files
  	@last_commit = Commit.where(project_file_id: @project_files.pluck(:id)).last
  	@comment = @project.comments.new
  	@comments = @project.comments.where(comment_id: nil).order("created_at DESC")
  end
end
