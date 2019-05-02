class PostsController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create]
  before_action :correct_user, only: :destroy
  def create
    @new_post = current_user.posts.new(post_params)
    @new_post.save
    redirect_to root_path
  end
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end
  private
    def post_params
      params.require(:post).permit(:content)
    end

    def logged_in_user
      unless logged_in?
        redirect_to login_path
      end
    end

    def correct_user
      user = Post.find(params[:id]).user
      unless current_user? user
        redirect_to root_path
      end
    end
end
