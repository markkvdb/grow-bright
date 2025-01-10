module ChildContext
  extend ActiveSupport::Concern

  included do
    before_action :set_child
  end

  private
    def set_child
      @child = Current.user.caregiver.children.find(params[:child_id])
      set_current_baby_id(@child.id)
    end
end 