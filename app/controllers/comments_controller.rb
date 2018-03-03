class CommentsController < ApplicationController
  
  def create
  	params[:comment][:statement] = params[:comment][:statement].gsub(/fuck/i, 'fudge')
  	params[:comment][:statement] = params[:comment][:statement].gsub(/hell/i, 'heck')
  	params[:comment][:statement] = params[:comment][:statement].gsub(/bitch/i, 'person')
  	params[:comment][:statement] = params[:comment][:statement].gsub(/dumbass/i, 'stupid')
  	params[:comment][:statement] = params[:comment][:statement].gsub(/asshole/i, 'jerk')
  	@comment = Comment.new(comments_params)

    if params[:comment_id]
      @comment.comment_id = params[:comment_id]
    end

    @comment.save

    if(@comment.errors)
      puts "================================================================================="
      puts @comment.errors.messages
      puts "================================================================================="
    end

    @comments = @comment.project.comments

    @html = ApplicationController.render(partial: "projects/comments", locals: { comments: @comments.where(comment_id: nil) }, formats: [:html])
     

    render json: { html: @html ,comment: @comment, comments: @comments ,upvotes_count: @comment.upvotes.count , status: "200"}
  end

  def sorted 
    if params[:by] == "upvotes"
      
      # @comments = Comment.joins(:upvotes).where(project_id: params[:project_id]).group("comments.id").order("count('up_votes.id') desc")
      
      @comments = Comment.where(project_id: params[:project_id],comment_id: nil)
      comment_votes_hash = @comments.map do |comment|
        {
          comment: comment,
          votes_count: comment.upvotes.count
        }
      end

      sorted_votes_comments = comment_votes_hash.sort_by { |k| k[:votes_count]}.reverse

      # @comments = Comment.where(project_id: 1,comment_id: nil)
      # comment_votes_hash = @comments.map do |comment|
      #   {
      #     comment: comment,
      #     votes_count: comment.upvotes.count
      #   }
      # end

      # sorted_votes_comments = comment_votes_hash.sort { |k| k[:votes_count]}

      puts "========================================================================="
      puts sorted_votes_comments
      puts "========================================================================="

      sorted_comments = sorted_votes_comments.map { |k| k[:comment] } 

      puts "========================================================================="
      puts sorted_comments
      puts "========================================================================="

      @html = commentsRenderer(sorted_comments)

      render json: { html: @html }

    elsif params[:by] == "subcomments" 
      
      @comments = Comment.where(project_id: params[:project_id],comment_id: nil)

      commentHash = @comments.map do |comment|
        count = 0
        count += comment.sub_comments.count
        comment.sub_comments.each do |subcomment|
            count += subcomment.sub_comments.count
            subcomment.sub_comments.each do |subsubcomment|
              count += subsubcomment.sub_comments.count
            end
        end
        {
          comment: comment,
          count: count
        }
      end

      puts "============================================================================="
      puts commentHash
      puts "============================================================================="

      sortedHash = commentHash.sort_by{ |k| k[:count] }.reverse

      puts "============================================================================="
      puts sortedHash
      puts "============================================================================="

      @commentsArray = sortedHash.map {|k| k[:comment]}

      # @comment = Comment.where(project_id: params[:project_id]).group(:comment_id).order("count(comment_id) asc") + Comment.where(project_id: params[:project_id],comment_id: nil)
      @html =  commentsRenderer(@commentsArray)

      render json: { html: @html } 
    end  
  end

  private

    def commentsRenderer comments
      ApplicationController.render(partial: "projects/comments", locals: { comments: comments }, formats: [:html])
    end

  	def comments_params
  		params.require(:comment).permit(:project_id, :statement)
  	end
end
