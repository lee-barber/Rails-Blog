class CommentsController < ApplicationController
	def index
        @comments = Comment.all
    end

    def new
        @user = User.find(current_user.id)
        @blog = Blog.find(params[:id])
        @comment = Comment.new
    end

    def create

        user = User.find(current_user.id)
        comment = Comment.new(comment_params)
        comment.user_id = current_user.id
        if comment.save!
            flash[:message] = 'Comment posted'
            redirect_to "/blogs/#{comment.blog_id}"
        else
            flash[:message] = 'Sorry, please try again.'
            render 'comments/new'
        end
    end

    def show
        @comment = Comment.find_by_id(params[:id])
    end

    def edit
        @comment = Comment.find_by_id(params[:id])
    end

    def update
        @blog = Blog.find_by_id(params[:id])
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            flash[:message] = 'Comment edited'
            redirect_to "/blogs/#{@comment.blog_id}"
        else
            flash[:message] = 'Sorry, please try again.'
            render "/comments/#{@comment.id}/edit"
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to "/blogs/#{@comment.blog_id}"
    end

private

def comment_params
    params.require(:comment).permit(:content, :user_id, :blog_id)
end
end
