class PostsController < InheritedResources::Base
  def index
    @search = Post.search params[:q]
    if params[:fs]
      if params[:fs][:term].blank?
        @posts = Post.all
      else
        @posts = tire_search_results params[:fs][:term], load: true
      end
    end
    @posts ||= @search.all
  end
end
