class Component < ApplicationRecord
    belongs_to :game
    has_many_attached :images

    enum typecomp: %w[piece part]
end
