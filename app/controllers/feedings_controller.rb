class FeedingsController < ApplicationController
  include ChildContext

  before_action :set_feeding, only: [ :show, :edit, :update, :destroy ]

  FEEDING_BASE_PARAMS = [ :feeding_type, :caregiver_id, :start_time, :end_time, :notes ].freeze

  FEEDING_TYPE_PARAMS = {
    "bottle" => [ :volume_value, :volume_unit ],
    "solid"  => [ :weight_value, :weight_unit ],
    "breast" => [ :side ]
  }.freeze

  def index
    @feedings = @child.feedings.order(start_time: :desc)
  end

  def show
  end

  def new
    @feeding = @child.feedings.build(
      start_time: Time.current,
      end_time: Time.current + 10.minutes,
      caregiver: @child.caregivers.first
    )
  end

  def create
    @feeding = @child.feedings.build(feeding_params)

    if @feeding.save
      redirect_to child_path(@child), notice: "Feeding was successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @feeding.update(feeding_params)
      redirect_to child_path(@child), notice: "Feeding was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @feeding.destroy
    redirect_to child_path(@child), notice: "Feeding was successfully deleted."
  end

  private

  def set_feeding
    @feeding = @child.feedings.find(params[:id])
  end

  def feeding_params
    feeding_type = params.dig(:feeding, :feeding_type)
    permitted_params = FEEDING_BASE_PARAMS + (FEEDING_TYPE_PARAMS[feeding_type] || [])

    params.require(:feeding).permit(*permitted_params)
  end
end
