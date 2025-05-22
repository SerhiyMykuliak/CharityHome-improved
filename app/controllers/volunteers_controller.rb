class VolunteersController < ApplicationController
  before_action :set_volunteer, only: %i[ show edit update destroy ]

  def index
    @volunteers = Volunteer.page(params[:page]).per(8)
  end

  def show
  end

  def new
    @volunteer = Volunteer.new
  end

  def edit
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)

    if @volunteer.save
      redirect_to @volunteer, notice: "Volunteer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update

    if @volunteer.update(volunteer_params)
      redirect_to @volunteer, notice: "Volunteer was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @volunteer.destroy!

    redirect_to volunteers_path, status: :see_other, notice: "Volunteer was successfully destroyed."
  end

  private

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :email, :phone_number, :city, :description, :birth_date, :facebook_url, :instagram_url, :twitter_url, :avatar)
  end
    
end
