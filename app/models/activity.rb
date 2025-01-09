class Activity < ApplicationRecord
  enum :activity_type, {
    tummy_time: 0,
    bath: 1,
    play: 2,
    walk: 3,
    massage: 4,
    other: 5
  }

  belongs_to :child
  belongs_to :caregiver

  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 100, 100 ]
    attachable.variant :medium, resize_to_fill: [ 300, 300 ]
    attachable.variant :large, resize_to_limit: [ 1200, 1200 ]
  end

  validates :activity_type, presence: true
  validates :start_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }, presence: true
  validates :milestone, inclusion: { in: [ true, false ] }
  validates :notes, length: { maximum: 65535 } # TEXT limit

  validate :validate_images

  MAX_IMAGE_SIZE = 10.megabytes
  MAX_IMAGES = 5

  private

  def validate_images
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(Rails.application.config.active_storage.web_image_content_types)
        errors.add(:images, "must be a JPEG or PNG")
      end

      if image.blob.byte_size > MAX_IMAGE_SIZE
        errors.add(:images, "size must be less than #{MAX_IMAGE_SIZE/1.megabyte}MB")
      end
    end

    if images.count > MAX_IMAGES
      errors.add(:images, "cannot attach more than #{MAX_IMAGES} images")
    end
  end
end
