class Program < ApplicationRecord
  belongs_to :channel
  validates :title, :start_time, :stop_time, presence: true
end
