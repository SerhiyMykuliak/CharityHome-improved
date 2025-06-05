class CommentsController < ApplicationController

def create
  @cause = Cause.find(params[:cause_id])
  @comment = @cause.comments.build(comment_params)

  if @comment.save
    respond_to do |format|
      format.html { redirect_to @cause }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.prepend("comments", partial: "comments/comment", locals: { comment: @comment }),
          turbo_stream.replace("new_comment_form", partial: "comments/new_comment_form", locals: { cause: @cause })
        ]
      end
    end 
  else
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("new_comment_form", partial: "comments/new_comment_form", locals: { cause: @cause, comment: @comment })
      end
    end 
  end
end 

private

def comment_params
  params.require(:comment).permit(:username, :email, :content)
end

end
