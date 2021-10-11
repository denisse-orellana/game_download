class Box < ApplicationRecord
    belongs_to :game
    has_one_attached :image

    validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
end
