class WorksController < ApplicationController
  before_action :authenticate_staff_user!
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  # GET /works
  # GET /works.json
  def index
    @works = Work.all
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @jobs = Job.all
    @events_by_date = @jobs.group_by do |job|
      job.work.start_datetime.strftime('%x')
    end
  end

  # GET /works/1
  # GET /works/1.json
  def show
  end

  # GET /works/new
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  # POST /works.json
  def create
    @user = current_staff_user
    @params = params[:work]
    params[:work]["start_datetime(1i)"] = @params[:date_y]
    params[:work]["start_datetime(2i)"] = @params[:date_m]
    params[:work]["start_datetime(3i)"] = @params[:date_d]
    params[:work]["end_datetime(1i)"] = @params[:date_y]
    params[:work]["end_datetime(2i)"] = @params[:date_m]
    params[:work]["end_datetime(3i)"] = @params[:date_d]
    @work = @user.works.new(set_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @work, notice: "workを作成しました" }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    respond_to do |format|
      if @work.update(set_params)
        format.html { redirect_to @work, notice: "workを更新しました" }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: "workを削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.fetch(:work, {}).permit(:start_datetime, :end_datetime, :store_id, :date_y, :date_m, :date_d)
    end

    def set_params
      params.fetch(:work, {}).permit(:start_datetime, :end_datetime, :store_id)
    end
end
