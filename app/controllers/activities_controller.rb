class ActivitiesController < ApplicationController
  before_action :set_child
  before_action :set_activity, only: [ :show, :edit, :update, :destroy ]

  def index
    @activities = @child.activities.order(start_time: :desc)
  end

  def show
  end

  def new
    @activity = @child.activities.build(
      start_time: Time.current,
      end_time: Time.current + 15.minutes,
      caregiver: @child.caregivers.first
    )
  end

  def create
    @activity = @child.activities.build(activity_params)

    if @activity.save
      redirect_to child_path(@child), notice: "Activity was successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to child_path(@child), notice: "Activity was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @activity.destroy
    redirect_to child_path(@child), notice: "Activity was successfully deleted."
  end

  private

  def set_child
    @child = Child.find(params[:child_id])
  end

  def set_activity
    @activity = @child.activities.find(params[:id])
  end

  def activity_params
    super_params = params.require(:activity).permit(
      :activity_type,
      :start_time,
      :end_time,
      :notes,
      :milestone,
      :caregiver_id,
      :images # This will receive a comma-separated list of signed IDs
    )

    # Convert comma-separated signed IDs to array of blobs
    if super_params[:images].present?
      super_params[:images] = super_params[:images].split(",")
    end

    super_params
  end
end
