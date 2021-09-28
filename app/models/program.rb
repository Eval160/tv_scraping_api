class Program < ApplicationRecord
  validates :title, :start_time, :stop_time, presence: true
end
