class CausesController < ApplicationController
  before_action :set_cause, only: %i[ show edit update destroy ]

  def index
    @causes = Cause.order(created_at: :desc)
    @tags = Tag.all

    @causes = @causes.where("title ILIKE ?", "%#{params[:title]}%") if params[:title].present?
    @causes = @causes.where(status: params[:status]) if params[:status].present?
    @causes = @causes.joins(:tags).where(tags: { id: params[:tag_id] }) if params[:tag_id].present?
    
    @causes = @causes.page(params[:page]).per(6)
  end

  def show
    @comments = @cause.comments.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @cause = Cause.new
    @tags = Tag.all
  end

  def edit
    @tags = Tag.all
  end

  def create
    @cause = Cause.new(cause_params)

    if @cause.save
      redirect_to @cause, notice: "Cause was successfully created." 
    else
      render :new, status: :unprocessable_entity
    end

  end

  def update

    if @cause.update(cause_params)
      redirect_to @cause, notice: "Cause was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end

  end

  def destroy
    @cause.destroy!
    redirect_to causes_path, status: :see_other, notice: "Cause was successfully destroyed."
  end

  private
    def set_cause
      @cause = Cause.find(params[:id])
    end

    def cause_params
      params.require(:cause).permit(:title, :description, :short_description, :goal_amount, :collected_amount, :status, :start_date, :end_date, :image, tag_ids: [])
    end
end
