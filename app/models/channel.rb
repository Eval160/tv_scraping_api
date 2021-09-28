class Channel < ApplicationRecord
  has_many :programs
  validates :name, :telerama_id, presence: true
end
