class Game < ApplicationRecord
  has_one :rule, dependent: :destroy
  has_many :components, dependent: :destroy
  has_one :box, dependent: :destroy

  enum typecomp: %w[piece part]

  accepts_nested_attributes_for :rule, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :components, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :box, reject_if: :all_blank, allow_destroy: true
end