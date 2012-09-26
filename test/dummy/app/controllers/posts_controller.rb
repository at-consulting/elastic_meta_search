class PostsController < InheritedResources::Base
  def index
    @search = Post.search params[:q]
    if params[:fs]
      if params[:fs][:term].blank?
        @posts = Post.all
      else
        term = "*#{params[:fs][:term]}*"
        @posts = Tire.search('posts', load: true, default_operator: 'AND') do
          query { string term }
        end.results
      end
    end
    @posts ||= @search.all
  end
end
