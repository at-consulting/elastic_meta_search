class PostsController < ApplicationController
  def index
    @search = Post.search params[:q]
    @posts = @search.all
  end
end
