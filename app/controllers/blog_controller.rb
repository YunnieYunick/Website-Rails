class BlogController < ApplicationController
  include Blog
  before_action :published_items, only: [:index, :show, :archives]
  include Dashboards
  before_action :get_dashboard, only: [:index, :show, :archives]

  def index
    @params = params[:search]
    if @params
      @posts = Post.where("title LIKE :title OR body LIKE :body", title: "%#{@params}%", body: "%#{@params}%").where(published: true).page(params[:page]).per(5)
    else
      @posts = @published_post.page(params[:page]).per(5)
    end
  end

  def show
    @post = Post.friendly.find(params[:id])
    @posts = Post.order('created_at DESC').limit(4).offset(1)
  end

  def archives
    @posts = Post.where("published_at like '%" + params[:id] + "%'").where(published: true).page(params[:page]).per(5)
  end

end
