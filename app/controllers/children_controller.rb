class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update, :destroy]

  def index
    @children = Current.user.caregiver.children.order(:first_name)
  end

  def show
    @recent_feedings = @child.feedings.order(start_time: :desc).limit(5)
    @recent_diapers = @child.diaper_changes.order(time: :desc).limit(5)
    @recent_activities = @child.activities.order(start_time: :desc).limit(5)
    @recent_measurements = @child.measurements.order(date: :desc).limit(5)
  end

  def new
    @child = Child.new
    @child.children_caregivers.build(
      caregiver: Current.user.caregiver,
      relationship: "parent"
    )
  end

  def create
    @child = Child.new(child_params)
    if @child.save
      set_current_child(child: @child)
      redirect_to @child, notice: "Child was successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @child.update(child_params)
      redirect_to @child, notice: "Child was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @child.destroy
    redirect_to children_path, notice: "Child was successfully deleted."
  end

  private

    def set_child
      @child = Current.user.caregiver.children.find(params[:id])
    end

    def child_params
      params.require(:child).permit(
        :first_name,
        :last_name,
        :birth_date,
        :birth_weight_value,
        :birth_weight_unit,
        :birth_length_value,
        :birth_length_unit,
        :avatar,
        children_caregivers_attributes: [:id, :caregiver_id, :relationship, :_destroy]
      )
    end
end
