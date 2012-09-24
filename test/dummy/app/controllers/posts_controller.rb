class PostsController < ApplicationController
  def index
    @search = Post.search params[:q]
    #@posts = @search.all

    query = "*" || params[:t]
    @fast_search = Tire.search('posts', load: true) do
      query { string query }
    end.results
    @posts = @fast_search.clone

  end
end
