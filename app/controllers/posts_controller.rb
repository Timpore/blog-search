class PostsController < ApplicationController
  before_action :index, :show do
    head :not_found if params[:domain].blank?
    head :not_found unless Post.for_domain(params[:domain]).exists?
  end

  def index
    @posts = Post.includes(:authors).for_domain(params[:domain]).title_search(params[:search])
  end

  def show
    @post = Post.find_by(domain: params[:domain], slug: params[:slug])
  end
end
