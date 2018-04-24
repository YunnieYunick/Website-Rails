class DashboardsController < ApplicationController
  before_action :authenticate_staff_user!
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]

  def index
    if Dashboard.all.empty?
      @dashboards = Dashboard.all
    else
      @dashboard = Dashboard.first
    end
    @topics = Topic.all
  end

  def show
    if Topic.first.present?
      @topic = Topic.friendly.find(params[:id])
    end
  end

  def new
    @dashboard = Dashboard.new
  end

  def edit
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: "#{@dashboard.site_name}を作成しました" }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: "#{@dashboard.site_name}を更新しました" }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: "#{@dashboard.site_name}を削除しました" }
      format.json { head :no_content }
    end
  end

  private
  def set_dashboard
    @dashboard = Dashboard.find(params[:id])
  end

  def dashboard_params
    params.fetch(:dashboard, {}).permit(:site_name, :site_description, :about_text)
  end
end
