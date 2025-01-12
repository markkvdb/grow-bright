module CurrentChild
  extend ActiveSupport::Concern

  included do
    before_action :set_current_child_from_url, :check_missing_child, if: -> { Current.user.present? }
    helper_method :set_current_child
  end

  private

    def set_current_child_from_url
      set_current_child_from_params
      set_current_child
    end

    def set_current_child(child: nil)
      @current_child = if child&.persisted?
        child
      else
        Current.user.caregiver.children.find_by(id: session[:current_child_id])
      end
    end

    def set_current_child_from_params
      # check if child id has changed
      child_id_param = controller_name == "children" ? params[:id] : params[:child_id]
      set_current_child_id(child_id_param) if child_id_param && child_id_param != session[:current_child_id]
    end

    def check_missing_child
      return if controller_name == "sessions"
      return if controller_name == "children" && action_name.in?(%w[index new create]) # Skip for baby selection page

      unless @current_child
        session.delete(:current_child_id)
        redirect_to root_path, alert: "Please select a baby to continue"
      end
    end

    def set_current_child_id(id)
      session[:current_child_id] = id
    end
end 