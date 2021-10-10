class Game < ApplicationRecord
  belongs_to :rule
  belongs_to :component
  belongs_to :box

  enum typecomp: %w[piece part]

  accepts_nested_attributes_for :rules, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :components, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :boxes, reject_if: :all_blank, allow_destroy: true
end
