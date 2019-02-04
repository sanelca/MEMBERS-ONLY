class StaticPagesController < ApplicationController
  def home
    @posts = Post.all
    @new_post = Post.new
  end
end
