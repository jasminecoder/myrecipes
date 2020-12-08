class Message < ApplicationRecord
    validates :content, presence: true
    validates :chef_id, presence: true
    belongs_to :chef
end