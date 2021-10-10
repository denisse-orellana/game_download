class Box < ApplicationRecord
    has_one :game
    has_one_attached :image
end
