class Component < ApplicationRecord
    belongs_to :game
    has_many_attached :images

    enum typecomp: %w[piece part]

    validates :images, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
end
