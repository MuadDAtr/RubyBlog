class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
        redirect_to post_path(@comment.post)
    end

    def comment_params
        params.require(:comment).permit(:author, :body)
    end

    def destroy
        @comment.destroy
    
        respond_to do |format|
          format.html { redirect_to posts_url, notice: "Comment was successfully destroyed." }
          format.json { head :no_content }
        end
    end
end
