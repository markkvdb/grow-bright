module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
    end
  end
end 