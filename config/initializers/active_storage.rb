Rails.application.configure do
  config.active_storage.variant_processor = :mini_magick

  # Set reasonable defaults for image processing
  config.active_storage.web_image_content_types = %w[image/jpeg image/jpg image/png]
  config.active_storage.content_types_allowed_inline = %w[image/jpeg image/jpg image/png]
  config.active_storage.content_types_to_serve_as_binary = %w[image/tiff]

  # Configure variants
  config.active_storage.track_variants = true

  # Allow images to be served inline
  config.active_storage.resolve_model_to_route = :rails_storage_proxy
end
