class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :published, :unpublished]
  before_action :authenticate_staff_user!
  include Blog
  before_action :published_items, only: [:show]
  include Dashboards
  before_action :get_dashboard

  # GET /posts
  # GET /posts.json
  def index
    @posts = current_staff_user.posts.order('created_at DESC').page(params[:page]).per(5)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @username = current_staff_user.username
    @posts = Post.order('created_at DESC').limit(4).offset(1)
    @categories = Category.all
  end

  # GET /posts/new
  def new
    @post = current_staff_user.posts.new
    @post.published_at = Time.now
  end

  # GET /posts/1/edit
  def edit
  end

  def published
    @post.published
    redirect_to posts_url
  end

  def unpublished
    @post.unpublished
    redirect_to posts_url
  end

  def booking
    @post.published(params[:post][:published_at])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_staff_user.posts.new(post_params)

    if params[:published]
      booking
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "#{@post.title}を保存しました" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

    if params[:published]
      booking
    else
      @post.unpublished
    end

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "#{@post.title}を更新しました" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "#{@post.title}を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_staff_user.posts.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :slug, :image, :delete_image, :user_id, :published, :published_at, :category_id, :tag_list)
    end
end
