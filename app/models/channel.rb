class Channel < ApplicationRecord
  validates :name, :telerama_id, presence: true
end
