class CausesController < ApplicationController
  before_action :set_cause, only: %i[ show edit update destroy ]

  def index
    @causes = Cause.all
  end

  def show
  end

  def new
    @cause = Cause.new
  end

  def edit
  end

  def create
    @cause = Cause.new(cause_params)

    respond_to do |format|
      if @cause.save
        format.html { redirect_to @cause, notice: "Cause was successfully created." }
        format.json { render :show, status: :created, location: @cause }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cause.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cause.update(cause_params)
        format.html { redirect_to @cause, notice: "Cause was successfully updated." }
        format.json { render :show, status: :ok, location: @cause }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cause.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cause.destroy!

    respond_to do |format|
      format.html { redirect_to causes_path, status: :see_other, notice: "Cause was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_cause
      @cause = Cause.find(params[:id])
    end

    def cause_params
      params.require(:cause).permit(:title, :description, :short_description, :goal_amount, :collected_amount, :status, :start_date, :end_date, :image)
    end
end
