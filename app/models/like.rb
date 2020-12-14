class Like < ApplicationRecord
    belongs_to :chef
    belongs_to :recipe
    validates :chef, :recipe, presence: true
    validates :liked, inclusion: [true, false]
end