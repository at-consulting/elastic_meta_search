class PostsController < ApplicationController
  def index
    @search = Post.search params[:q]
    @posts = @search.all
  end

  def es
    term = "*#{params[:term]}*"
    results = Tire.search('posts') do
      query { string term }
      highlight :name, :author, options: { tag: '' }
    end.results
    highlights = results.map(&:highlight).flatten.map(&:to_hash)
    res = []
    raise highlights.inspect
    highlights.each do |hash|
      hash.each do |k,v|
        res << { column: k, value: v.first, label: v.first }
      end
    end
    render json: res.to_json
  end
end


