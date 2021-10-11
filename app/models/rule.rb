class Rule < ApplicationRecord
    belongs_to :game
    has_one_attached :document

    validates :document, presence: true, blob: { content_type: ['application/pdf'], size_range: 1..5.megabytes }
end
