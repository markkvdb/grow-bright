class ActivitiesController < ApplicationController
  before_action :set_child
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

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
      redirect_to child_path(@child), notice: 'Activity was successfully recorded.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to child_path(@child), notice: 'Activity was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @activity.destroy
    redirect_to child_path(@child), notice: 'Activity was successfully deleted.'
  end

  def remove_image
    @activity = @child.activities.find(params[:id])
    image = @activity.images.find(params[:image_id])
    image.purge
    
    respond_to do |format|
      format.html { redirect_to edit_child_activity_path(@child, @activity), notice: 'Image was successfully removed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(image) }
    end
  end

  private

  def set_child
    @child = Child.find(params[:child_id])
  end

  def set_activity
    @activity = @child.activities.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(
      :activity_type,
      :start_time,
      :end_time,
      :milestone,
      :notes,
      :caregiver_id,
      images: []
    )
  end
end 