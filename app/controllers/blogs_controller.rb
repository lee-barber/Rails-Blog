class BlogsController < ApplicationController
	def index
        @blogs = Blog.all
    end

    def new
        @user = User.find(current_user.id)
        @blog = Blog.new    
    end

    def create
        @user = User.find(current_user.id)
        blog = Blog.new(blog_params)
        blog.user_id = current_user.id
        puts "this is #{blog.id}"
        if blog.save!
            flash[:message] = 'Blog was created!'
            redirect_to '/blogs'
        else
            flash[:message] = 'Sorry, please try again.'
            render '/blogs/new'
        end
        
    end

    def show
        @blog = Blog.find_by_id(params[:id])
        @comment = Comment.new
        # @current_comment = Comment.find(params[:id])
    end

    def edit
        @blog = Blog.find_by_id(params[:id])
    end

    def update
        @blog = Blog.find(params[:id])
        if @blog.update(blog_params)
            flash[:message] = 'Blog was updated!'
            redirect_to "/blogs/#{@blog.id}"
        else
            flash[:message] = 'Sorry, please try again.'
            render "/blogs/#{@blog.id}/edit"
        end
    end

    def destroy
        @blog = Blog.find(params[:id])
        @blog.destroy
        redirect_to '/blogs'
    end

private

def blog_params
    params.require(:blog).permit(:title, :content)
end

def user_params
params.require(:user).permit(:id)
end

def comments_params
    params.require(:comment).permit(:content)
end

end
