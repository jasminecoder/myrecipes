class Like < ApplicationRecord
    belongs_to :chef
    belongs_to :recipe
    validates_presence_of :chef, :recipe, :liked
    # validates :chef_id, uniqueness: { scope: [:recipe_id, :liked]}
end