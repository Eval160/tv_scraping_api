class Channel < ApplicationRecord
  has_many :programs, dependent: :destroy
  validates :name, :telerama_id, presence: true
  validates :name, uniqueness: true
end
