class Component < ApplicationRecord
    has_one :game
    has_many_attached :images

    enum typecomp: %w[piece part]
end
