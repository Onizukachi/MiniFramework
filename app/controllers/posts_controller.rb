class PostsController < BaseController
  def index
    @posts = Post.all
  end
end
