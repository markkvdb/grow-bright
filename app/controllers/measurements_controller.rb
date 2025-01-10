class MeasurementsController < ApplicationController
  include ChildContext
  before_action :set_measurement, only: [ :show, :edit, :update, :destroy ]

  def index
    @measurements = @child.measurements.order(date: :desc)
  end

  def show
  end

  def new
    @measurement = @child.measurements.build(
      date: Date.current,
      caregiver: @child.caregivers.first
    )
  end

  def create
    @measurement = @child.measurements.build(measurement_params)

    if @measurement.save
      redirect_to child_path(@child), notice: "Measurement was successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @measurement.update(measurement_params)
      redirect_to child_path(@child), notice: "Measurement was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @measurement.destroy
    redirect_to child_path(@child), notice: "Measurement was successfully deleted."
  end

  private

  def measurement_params
    params.require(:measurement).permit(
      :date,
      :weight_value,
      :weight_unit,
      :length_value,
      :length_unit,
      :head_circumference_value,
      :head_circumference_unit,
      :notes,
      :caregiver_id
    )
  end
end
