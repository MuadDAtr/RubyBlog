class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
        redirect_to post_path(@comment.post)
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

    def destroy
        @comment.destroy
    
        respond_to do |format|
          format.html { redirect_to posts_url, notice: "Comment was successfully destroyed." }
          format.json { head :no_content }
        end
    end
end
