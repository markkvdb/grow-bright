class DiaperChangesController < ApplicationController
  include CurrentChild
  include ChildContext

  before_action :set_diaper_change, only: [ :show, :edit, :update, :destroy ]

  DIAPER_BASE_PARAMS = [ :change_type, :caregiver_id, :time, :notes ].freeze

  DIAPER_TYPE_PARAMS = {
    "solid" => [ :color, :consistency ],
    "both"  => [ :color, :consistency ]
  }.freeze

  def index
    @diaper_changes = @child.diaper_changes.order(time: :desc)
  end

  def show
  end

  def new
    @diaper_change = @child.diaper_changes.build(
      time: Time.current,
      caregiver: @child.caregivers.first
    )
  end

  def create
    @diaper_change = @child.diaper_changes.build(diaper_change_params)

    if @diaper_change.save
      redirect_to child_path(@child), notice: "Diaper change was successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @diaper_change.update(diaper_change_params)
      redirect_to child_path(@child), notice: "Diaper change was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diaper_change.destroy
    redirect_to child_path(@child), notice: "Diaper change was successfully deleted."
  end

  private

  def set_diaper_change
    @diaper_change = @child.diaper_changes.find(params[:id])
  end

  def diaper_change_params
    change_type = params.dig(:diaper_change, :change_type)
    permitted_params = DIAPER_BASE_PARAMS + (DIAPER_TYPE_PARAMS[change_type] || [])

    params.require(:diaper_change).permit(*permitted_params)
  end
end
