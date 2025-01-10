module CurrentBaby
  extend ActiveSupport::Concern

  included do
    before_action :set_current_baby
    helper_method :current_baby
  end

  private
    def current_baby
      @current_baby ||= Current.user.caregiver.children.find_by(id: cookies.signed[:current_baby_id]) if Current.user
    end

    def set_current_baby
      return if controller_name == "sessions" # Skip for login/logout
      return if controller_name == "children" && action_name == "index" # Skip for baby selection page

      unless current_baby
        cookies.delete(:current_baby_id)
        redirect_to root_path, alert: "Please select a baby to continue"
      end
    end

    def set_current_baby_id(id)
      cookies.signed[:current_baby_id] = {
        value: id,
        expires: 1.year.from_now,
        httponly: true
      }
    end
end 