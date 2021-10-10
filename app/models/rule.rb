class Rule < ApplicationRecord
    has_one :game
    has_one_attached :document
end
